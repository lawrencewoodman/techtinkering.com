---
layout: article
title: "Writing my First Program to Toggle in to the IMSAI 8080"
summaryPic: small_imsai_frontpanel_z80pack_ones_zeros.jpg
summaryPicTitle: "I have been staring at Binary for too long"
tags:
  - 8080
  - IMSAI
  - Programming
  - Retro
  - Assembly
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
I have long been fascinated with entering programs into computers by methods not involving a standard keyboard and monitor.  This interest was peeked by my last article: [Using the latest z80pack, version 1.17, to emulate an Altair 8800 or IMSAI 8080 using the new graphical FrontPanel](/2008/10/29/using-the-latest-z80pack-version-1-17-to-emulate-an-altair-8800-or-imsai-8080-using-the-new-graphical-frontpanel).  I have therefore chosen to design and write a program for the IMSAI 8080.  In this article I will show you how I went about it, and how you could do the same.  You may want to look at the afore mentioned article if you don't own an IMSAI 8080 and don't already have an emulator for it.

## Gathering Information
Having never programmed an IMSAI 8080 before, I needed to gather some information about it and the Intel 8080 CPU that it uses.  I didn't find much out there, but what I did is listed below.

* [IMSAI 8080 User's Manual (pdf)](ftp://ftp.unix4fun.org/z80pack/imsai/IMSAI-8080_manual.pdf)
* [Intel 8080/Z80 Instruction Set and Comparison](http://nemesis.lonestar.org/computers/tandy/software/apps/m4/qd/opcodes.html)
* [Intel 8080 Architecture information](http://www.conservapedia.com/Intel_8080)
* [Intel 8080 Brief Explanation of the instructions](http://maben.homeip.net/static/S100/altair/software/8080.txt)
* [Intel 8080 Instruction Set](http://comsci.us/cpu/8080/isindex.html)

Armed with the above information and the knowledge that the _PROGRAMMED INPUT/OUTPUT_ on the Front Panel is available via port `0xFF`, I could now proceed.

## Specification of Program
The main consideration in choosing what program to create, is that it has to be small as I want to toggle it in via the front panel switches.  I would also like to be able to control it via the _PROGRAMMED INPUT_ switches.  After some deliberation, I have decided to write a program to bounce a light back and forth on the _PROGRAMMED OUTPUT_.  The speed of the light's movement will be controlled by the _PROGRAMMED INPUT_, so that when set to 0x00 it will be fast and then get slower as the _PROGRAMMED INPUT_ is increased to `0xFF`.  This may not be the most exciting program ever, but with all that switch flipping, I don't want to attempt anything too ambitious.


## Designing the Program
The program needs to be well designed before it is entered into the computer due to the difficulty of making changes once it has been entered.  I am therefore going to use a form of Top-Down, Stepwise Refinement to ensure that the program is correct before entering.

### High Level Pseudo Code
{% highlight text %}
Initialise variables
do {
    Change direction of light if at either end
    Move position of light
    Output position of light to PROGRAMMED_OUTPUT display
    Delay for a period of time controlled by the PROGRAMMED_INPUT
} while(true)
{% endhighlight %}

### Refined Pseudo Code
{% highlight text %}
// Initialise variables
direction = right   
position = 1

// Block of code that is repeated indefinitely
do {

  // Change direction of light if at either end
  if( position == 128 || position == 1 )
    direction = ~direction
	
  // Move position of light
  if( direction == left )
    rotateLeft position
  else
    rotateRight position


  // Output light to PROGRAMMED_OUTPUT display
  output PROGRAMMED_OUTPUT, position

  // Delay for a period of time controlled by the PROGRAMMED_INPUT
  for( userDelay = (input PROGRAMMED_INPUT)+1; userDelay > 0; userDelay-- ) {
    for( i = 2; i > 0; i-- ) {
      for( j = 255; j > 0; j-- ) {}
    }
  }
	
} while(true)	// Loop indefinitely
{% endhighlight %}

I have chosen to store the position of the light as the value of the bit set in that position, so that I can then easily output it to the _PROGRAMMED OUTPUT_.

## Testing the Design
Before I implement the design in Machine Code, I want to test that it is correct.  This is particularly important due to the difficulty in toggling programs in to the IMSAI.  To do this I want to look at several points in the code when they are presented with certain values.  I will run through the design in the following table:
<table class="neatTable"><tr><th>Direction</th><th>Position</th><th>Code</th><th>Comment</th></tr>
<tr><td>?</td><td>?</td><td>direction = right</td><td>Start of program</td></tr>
<tr><td>right</td><td>?</td><td>position = 1</td><td></td></tr>
<tr><td>right</td><td>1</td><td>if( position == 128 || position == 1 )</td><td>true</td></tr><tr><td>right</td><td>1</td><td>direction = ~direction</td><td></td></tr>
<tr><td>left</td><td>1</td><td>if( direction == left )</td><td>true</td></tr>
<tr><td>left</td><td>1</td><td>rotateLeft position</td><td></td></tr>
<tr><td>left</td><td>2</td><td>    :     :     :</td><td>Output and delay</td></tr>
<tr><td>left</td><td>2</td><td>if( position == 128 || position == 1 )</td><td>false</td></tr>
<tr><td>left</td><td>2</td><td>if( direction == left )</td><td>true</td></tr>
<tr><td>left</td><td>1</td><td>rotateLeft position</td><td></td></tr>
<tr><td>left</td><td>4</td><td>    :     :     :</td><td>Output and delay</td></tr>
<tr><td>left</td><td>128</td><td>    :     :     :</td><td>After a few iterations</td></tr>
<tr><td>left</td><td>128</td><td>if( position == 128 || position == 1 )</td><td>true</td></tr>
<tr><td>left</td><td>128</td><td>direction = ~direction</td><td></td></tr>
<tr><td>right</td><td>128</td><td>if( direction == left )</td><td>false</td></tr>
<tr><td>right</td><td>128</td><td>rotateRight position</td><td></td></tr>
<tr><td>right</td><td>64</td><td>    :     :     :</td><td>Output and delay</td></tr>
</table>

I am happy that the design is correct from looking at this table.  The first light to be turned on will be light 2, which is fine as the light is moving anyway.  It is easy to alter this if you are so inclined.  You can also use this method to check that the machine code implementation below is correct.

## Implementing the Design in Machine Code
To make the implementation easier I am going to store the Direction and Position variables in registers.  I will use the following process to convert the design into machine code:
1. Write the program out in assembler using labels to record program locations.
2. Put the hex equivalents to the assembler next to the appropriate lines, leaving unknown addresses marked with ????.
3. Put the address of each line at the start of it.
4. Go back and fill in the addresses marked with ????.
5. Convert the hex into binary next to each line.

This gives me the following code:
{% highlight text %}
      //-----------------------------------
      // Initialise the register variables
      //-----------------------------------
0000  mvi c,FF            // Set direction = right                0EFF   = 0000 1110
                          // 0 is left, 0xFF is right                      1111 1111
0002  mvi d,1             // Set position = 1                     1601   = 0001 0110
                                                                           0000 0001

:loop
      //-----------------------------------------
      // Move the recorded position of the light
      //-----------------------------------------
0004  mov a,d             // Load Position into Accumulator       7A     = 0111 1010
0005  cpi 128                                                     FE80   = 1111 1110
                                                                           1000 0000
0007  jz switchDirection  // Position = 128?                      CA0F00 = 1100 1010
                                                                           0000 1111
                                                                           0000 0000
000A  cpi 1                                                       FE01   = 1111 1110
                                                                           0000 0001
000C  jnz movePosition    // Position != 1?                       C21200 = 1100 0010
                                                                           0001 0010
                                                                           0000 0000

      // Switch the direction of the light
:switchDirection
000F  mov a,c             // Load Direction into Accumulator      79     = 0111 1001
0010  cma                 // Compliment the accumulator           2F     = 0010 1111
0011  mov c,a             // Store result back in the Direction   4F     = 0100 1111

:movePosition
0012  mov a,c             // Load Direction into Accumulator      79     = 0111 1001
0013  cpi 0               // Direction != left?                   FE00   = 1111 1110
                                                                           0000 0000
0015  jnz moveRight                                               C21E00 = 1100 0010
                                                                           0001 1110
                                                                           0000 0000
      // Move position Left
0018  mov a,d             // Load Position into Accumulator       7A     = 0111 1010
0019  ral                 // Rotate left                          17     = 0001 0111
001A  mov d,a             // Store result back in the Position    57     = 0101 0111
001B  jmp outputLight                                             C32100 = 1100 0011
                                                                           0010 0001
                                                                           0000 0000
      // Move position Right
:moveRight
001E  mov a,d             // Load Position into Accumulator      7A      = 0111 1010
001F  rar                 // Rotate right                        1F      = 0001 1111
0020  mov d,a             // Store result back in Position       57      = 0101 0111
		
      //-----------------------------------------------
      // Output the light to PROGRAMMED OUTPUT display
      //-----------------------------------------------
:outputLight
0021  mov a,d             // Load Position into Accumulator      7A      = 0111 1010
0022  cma                 // Compliment Accumulator due          2F      = 0010 1111
                          // to way PROGRAMMED OUTPUT works
0023  out FF              // Output to PROGRAMMED OUTPUT         D3FF    = 1101 0011
                                                                           1111 1111

      //-----------------------
      // User controlled Delay
      //-----------------------
0025  in FF               // User delay from PROGRAMMED INPUT    DBFF    = 1101 1011
                          // port 0xFF                                     1111 1111
0027  inr a               // Make sure 0 is minimum delay        3C      = 0011 1100

:delayOuter
0028  mvi b, 02           // Set register B loop delay to 2      0602    = 0000 0110
                                                                           0000 0010

:delayInner1
002A  mvi e, FF           // Set register E loop delay to 255    1EFF    = 0001 1110
                                                                           1111 1111

:delayInner2
002C  dcr e               // Decrement Register E                1D      = 0001 1101
002D  jnz delayInner2     // Loop until Register E = 0           C22C00  = 1100 0010
                                                                           0010 1100
                                                                           0000 0000

0030  dcr b               // Decrement Register B                05      = 0000 0101
0031  jnz delayInner1     // Loop until Register B = 0           C22A00  = 1100 0010
                                                                           0010 1010
                                                                           0000 0000

0034  dcr a               // Decrement Accumulator               3D      = 0011 1101
0035  jnz delayOuter      // Loop until Register A = 0           C22800  = 1100 0010
                                                                           0010 1000
                                                                           0000 0000
      //-------------------
      // Loop indefinitely
      //-------------------
0038  jmp loop                                                   C30400  = 1100 0011
                                                                           0000 0100
                                                                           0000 0000
{% endhighlight %}

## Entering the program into the IMSAI 8080
The next bit is a little nerve racking and quite laborious.  There are `0x40` bytes of code here, which is 512 bits.  512 ones and zeros that have to be entered exactly.  512 ones and zeros that if not entered correctly mean either re-entering the whole program again, or going back through them to check which were entered incorrectly.  As well as this; if the program doesn't work, is it because the program is wrong, or because I entered it in wrong?  But now is not the time to worry, I have tested the program on paper, the design is sound, I need to grab the bull by the horns and enter this program.

To enter the program follow these instructions:
1. Turn the machine on by moving the _PWR ON / PWR OFF_ switch to _PWR ON_.  This switch is located at the far-right of the unit.
2. The machine is now at address 0.  To input the first line of the program move the middle set of switches so that positions 3,2,1 are down.  This corresponds to binary: 0000 1110 from Address 0 of the program.
3. Press the _DEPOSIT / DEPOSIT NEXT_ switch into the _DEPOST_ position.  This puts the data from the switches set above into memory at the current address, which is currently 0.
4. Set the middle group of switches so that it corresponds to the binary in the next group of 8 bits of the program.
5. Press the _DEPOST / DEPOSIT NEXT_ switch into the _DEPOSIT NEXT_ position.  This increments the current address, and there it puts the data from the switches just set.
6. Repeat lines 4 and 5 until the program has been entered.

The program can now be run by moving the _RUN / STOP_ switch into the _RUN_ position.  You should now see the light bouncing back and forth in the PROGRAMMED OUTPUT at the top left of the unit.  If you now move any of the _PROGRAMMED INPUT_ switches, you will see that the light's movement changes speed.

## Debugging the Program
There are three main methods to help debug a program on the IMSAI:
1. _Step through the program_Do this by moving the _RUN / STOP_ switch into the _STOP_ position.  Now press the _SINGLE STEP_ switch for each step you want to see.  The current address will be displayed in the bottom middle lights, and it's contents in the top middle lights.  To run or step from a certain point, just examine that address first.
2. _Examine the contents of an address in memory_Do this by setting the left and middle group of switches to the address you want to examine, then move the _EXAMINE / EXAMINE NEXT_ switch into the _EXAMINE_ position.  You will now see it's contents in the middle top group of lights.  To see the contents of the next address just press _EXAMINE NEXT_.
3. _Change the contents of an address in memory_Do this by first examining the contents of the address using the _EXAMINE_ switch as above.  Then set the middle group of switches to the data you want to put there, and press _DEPOSIT_.  To continue entering data just set the middle switches to the next byte you want to enter and press _DEPOSIT NEXT_.

The program listing I have given works fine.  However when I first wrote it, I had line 0x0028 read:
{% highlight text %}
0028  mvi b, FF           // Set register B loop delay to 255    06FF    = 0000 0110
                                                                           1111 1111
{% endhighlight %}

This made the program much too slow, and at first I didn't think the program was working at all.  Using the above debugging methods it was easy to step through the program and work out what was happening.  I just changed the byte at `0x0029` to `02`, then examined address `0x0000`, and pressed the _RUN_ switch to run the program from `0x0000` (The start).  I then felt waves of euphoria as my program worked correctly.  I had done it with only one small hitch. 

## The Program Running on a Real IMSAI 8080

<object style="margin-top: 1em; margin-right:1em; margin-bottom:1em;" align="left" width="650" height="394">
  <param name="movie" value="http://www.youtube.com/v/7op5spoIcW4&amp;hl=en&amp;fs=1"></param>
  <param name="allowFullScreen" value="true"></param>
  <param name="allowscriptaccess" value="always"></param>
  <embed src="http://www.youtube.com/v/7op5spoIcW4&amp;hl=en&amp;fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="650" height="394"></embed>
</object>

Since writing this article I have been contacted by Mike Loewen, who has a real IMSAI and has kindly allowed me to upload this footage of my program running on his machine.  Mike has 
an interesting site about his [Old Technology Collection](http://sturgeon.css.psu.edu/~mloewen/Oldtech/) which features his [Restoration of an IMSAI 8080](http://sturgeon.css.psu.edu/~mloewen/Oldtech/IMSAI/).  I must say it was really good to see my program running on a real machine.  If only I could lay my hands on one.

<br style="clear: left;"/>
## Where Now?
Now is the time to get really creative.  To do this though, you need to really understand the machine, so the links at the start of the article should help you understand more about the machine and the Intel 8080 chip that powers it.  If you remember the importance of designing and testing the program properly before you enter it, you should be fine.  Good luck and have fun.
