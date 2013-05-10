---
layout: article
title: "The Smallest Communication Program in the World?"
summaryPic: small_small_comm_program.jpg
tags:
  - 80x86
  - DOS
  - Programming
  - Retro
  - Assembly
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
I was going through a backup of my dos machine, taken in 1998, and came across some source code which I haven't seen for a long time.  It was great to see that old code, and I must set-up a machine so that I can run some of it again.  In particular I came across an attempt at writing the world's smallest communication program for an x86 based PC running DOS.  I used to love writing these sort of little programs to test different things.  I know we get more done these days, but it was fun tinkering around at such a low-level.  So here follows the program.

## The Assembly Code
The following code was written, for Borland Turbo Assembler, when I was 17.  It maybe that, with experience, I could now write a smaller version, so my boast of 15 years ago may no longer be true! 

{% highlight nasm %}
;----------------------------------------------------------------------------
; This is probably the smallest modem communication program in the world,
; and was written to make a smaller program than Doug Cox's comms program,
; which was claimed to be the smallest.
;
; Doug Cox's program : 72 bytes
; My program         : 50 bytes
;
; You use AT commands to control the modem.
;
; The following functions are also provided:
;       ALT + C    Clear the screen
;       ALT + X    Exit
;
;----------------------------------------------------------------------------
;   Program name : ljatcom
;   File name	 : ljatcom.asm
;   Author	 : Lawrence Woodman
;   Date         : 11 December 1994
;----------------------------------------------------------------------------
.model small
.code
org 100h

pregetstatus:
  mov  ax, 3
  int  10h

getstatus:
  mov  dx, 2FDh              ; Line status Register
  in   al, dx
  and  al,1
  jz   check_for_key         ; If nothing from modem
  mov  dx,2F8h               ; Receive/Transmit Date Register
  in   al,dx                 ; Receive it
  mov  ah,0Eh                ; Function to write char on screen
  int  10h
  jmp  short getstatus

check_for_key:
  mov  ah, 1                 ; Function to get keyboard status
  int  16h
  jz   getstatus             ; If no keyboard input
  dec  ah                    ; Function to get keyboard char
  int  16h
  cmp  ax,2E00h              ; ALT-C
  je   pregetstatus
  cmp  ax,2D00h              ; ALT-X
  je   exit
  mov  dx,2F8h               ; Receive/Transmit Data Register
  out  dx,al                 ; Send it
  jmp  short getstatus

exit:
  ret

end pregetstatus
{% endhighlight %}

## Assembling

I used Borland Turbo Assembler to assemble this file and produce an executable `.COM` file:
{% highlight bat %}
C:\> tasm ljatcom.asm
C:\> tlink ljatcom /x /tdc
{% endhighlight %}

If you don't have this assembler, the source can easily be converted to the format of your favourite assembler.

## Using Debug to Create the Executable

For those not able to assemble the above code, I created a script with `HEXBUG` which can be run through the DOS command, `debug`, which will create the executable `.COM` file.

Copy the following script into `ljatcom.bug`

{% highlight text %}
NLJATCOM.COM
E100 B8 3 0 CD 10 BA FD 3 EC"$"1"t"A BA F8 3 EC B4 E CD 10 EB EE B4
E118 1 CD 16"t"E8 B4 0 CD 16"="0".t"DA"="0"-t"6 BA F8 3 EE EB D4 C3
RCX
32
W
Q HEXBUG Version 1.02 by Chad Wagner
{% endhighlight %}

Run this script through debug:
{% highlight bat %}
C:\> debug < ljatcom.bug
{% endhighlight %}

## Using the Program
This program is very simple, as you can see, and operates on COM2.  It is so small because it relies on your ability to command the modem directly.

To run it just type:
{% highlight bat %}
C:\> ljatcom
{% endhighlight %}

### Commanding a Hayes Compatible Modem

To reset the modem:
{% highlight text %}
ATZ
{% endhighlight %}

To dial a number, where _number_ is the number that you wish to dial:
{% highlight text %}
ATDnumber
{% endhighlight %}


### Operating Once the Connection Has Been Established
Once the number has been dialed, by using the above commands, the modem will establish the connection and you will be linked to the computer on the other end of the modem.  Most dial-up systems, however, use a variety of terminal emulations to control how to display things on your screen, so you will have to use a basic plain text protocol. 

## File Transfer
I once had an old machine on which the 5&frac14;&quot; drive wasn't working, so I couldn't transfer anything to or from it.  I had no other drive with me to replace it, so I connected the machine to another using a null-modem cable.  I then entered a slightly altered version of the above program, using debug, into both machines.  This allowed me to redirect it's output to a file on one end, and send a serial transfer program to it from the other end.  To make this transfer reliable enough, all I had to do was slow the COM port down with the DOS command `mode`.  For these sorts of transfers, if nothing else, the program could still be of some use to those operating older machines.
