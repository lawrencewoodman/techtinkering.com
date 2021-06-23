I quite enjoy designing machine language routines on paper and then hand assembling them.  For many people this would have been their only option until they got a more advanced machine language monitor or assembler.  I want to show how to approach this and how to enter these programs on the Vic.


## An Example Program

As an example I'm going to show how to create a routine that cycles through the various [screen border and background colour combinations](https://archive.org/details/VIC-20ProgrammersReferenceGuide1stEdition6thPrinti/page/n279 "VIC-20 Programmers Reference Guide, page 265") by changing the value of `$900F`.

It is easier to create the routine if we use a coding sheet like the one below to record the mnemonics, operands, labels and comments.  In many respects this is similar to how we would create the routine using source code on a computer which is going to be run through an assembler, but on paper.

<div class="neatTable-responsive">
  <table class="neatTable">
    <tr>
      <th>Address</th>
      <th>Code</th>
      <th>Label</th>
      <th>Mnemonic</th>
      <th>Operand</th>
      <th>Comment</th>
    </tr>
    <tr><td class="right"></td><td></td><td></td><td class="centre">LDA</td><td>$900F</td><td>Record initial screen border/background combo</td></tr>
    <tr><td class="right"></td><td></td><td></td><td class="centre">LDX</td><td>#$FF</td><td>First combo is $FF</td></tr>
    <tr><td class="right"></td><td></td><td>SETCOMBO</td><td class="centre">STX</td><td>$900F</td><td>Set screen border/background combo</td></tr>
    <tr><td class="right"></td><td></td><td></td><td class="centre">LDY</td><td>#$FF</td><td>Time delay</td></tr>
    <tr><td class="right"></td><td></td><td>DELAY</td><td class="centre">DEY</td><td></td><td></td></tr>
    <tr><td class="right"></td><td></td><td></td><td class="centre">BNE</td><td>DELAY</td><td></td></tr>
    <tr><td class="right"></td><td></td><td></td><td class="centre">DEX</td><td></td><td>Next combo</td></tr>
    <tr><td class="right"></td><td></td><td></td><td class="centre">BNE</td><td>SETCOMBO</td><td></td></tr>
    <tr><td class="right"></td><td></td><td></td><td class="centre">STA</td><td>$900F</td><td>Restore initial screen border/background combo</td></tr>
    <tr><td class="right"></td><td></td><td></td><td class="centre">RTS</td><td></td><td></td></tr>
  </table>
</div>



Once the routine is created we can enter the addresses and enter the machine code using [lookup tables for opcodes and two's complement](/articles/6502-machine-language-tables-and-aids/ "6502 Machine Language Tables and Aids").  This routine doesn't jump to any absolute addresses and therefore can be located wherever we find suitable.  Where I have filled in the addresses I have started at location `$02A1` as there is free space here between `$02A1` and `$02FF` which is reserved for user program indirects.


<div class="neatTable-responsive">
  <table class="neatTable">
    <tr>
      <th>Address</th>
      <th style="width: 6em;">Code</th>
      <th>Label</th>
      <th>Mnemonic</th>
      <th>Operand</th>
      <th>Comment</th>
    </tr>
    <tr><td class="right">02A1</td><td>AD 0F 90</td><td></td><td class="centre">LDA</td><td>$900F</td><td>Record initial screen border/background combo</td></tr>
    <tr><td class="right">02A4</td><td>A2 FF</td><td></td><td class="centre">LDX</td><td>#$FF</td><td>First combo is $FF</td></tr>
    <tr><td class="right">02A6</td><td>8E 0F 90</td><td>SETCOMBO</td><td class="centre">STX</td><td>$900F</td><td>Set screen border/background combo</td></tr>
    <tr><td class="right">02A9</td><td>A0 FF</td><td></td><td class="centre">LDY</td><td>#$FF</td><td>Time delay</td></tr>
    <tr><td class="right">02AB</td><td>88</td><td>DELAY</td><td class="centre">DEY</td><td></td><td></td></tr>
    <tr><td class="right">02AC</td><td>D0 FD</td><td></td><td class="centre">BNE</td><td>DELAY</td><td></td></tr>
    <tr><td class="right">02AE</td><td>CA</td><td></td><td class="centre">DEX</td><td></td><td>Next combo</td></tr>
    <tr><td class="right">02AF</td><td>D0 F5</td><td></td><td class="centre">BNE</td><td>SETCOMBO</td><td></td></tr>
    <tr><td class="right">02B1</td><td>8D 0F 90</td><td></td><td class="centre">STA</td><td>$900F</td><td>Restore initial screen border/background combo</td></tr>
    <tr><td class="right">02B4</td><td>60</td><td></td><td class="centre">RTS</td><td></td><td></td></tr>
  </table>
</div>


This leaves us with the following machine code:

``` text
AD 0F 90 A2 FF
8E 0F 90 A0 FF
88 D0 FD CA D0
F5 8D 0F 90 60
```

## BASIC Data Statements
One of the easiest ways to enter a routine into memory is to to convert the machine code to decimal and `poke` it.  This works well for short machine code routines, but the `data` statements take up quite a lot of memory and sometimes it is better to put the routine directly into memory and load it separately.

``` basic
10 for a=673 to 692
20 read b
30 poke a,b
40 next a
50 data 173,15,144,162,255,142,15,144,160,255
60 data 136,208,253,202,208,245,141,15,144,96
```


## A Simple Hex Loader
This is almost a machine language monitor and is one of the quickest and easiest ways to enter machine language directly onto a Vic.  This could be used when we have created our program by hand and just want to enter the hex codes into the computer to test it.  It is also useful to load the machine code for a proper monitor.  The address is in decimal but each byte is entered in hex.

The program is based on one in [Vic-20 Machine Code by Bruce Smith](https://archive.org/details/VIC-20_Machine_Code/page/n27 "Vic-20 Machine Code, Page 22").

``` basic
10 print chr$(147)
20 input "start address:";a
30 print a;":$";
40 gosub 100:h=n:print z$;
50 gosub 100:l=n:print z$
60 b=h*16+l:poke a,b
70 a=a+1:goto 30

100 get z$
110 if z$="s" then end
120 if z$>"f" then 100
130 if z$ >="a" and z$ <= "f" then n=asc(z$)-55:return
140 if z$ = "" then 100
150 n=val(z$):return
```

To see how to save and load memory to disk or cassette have a look at our article: [Saving and Loading Memory on the VIC-20](/articles/saving-and-loading-memory-on-the-vic-20/).

## Video Demonstrating Hand Assembling to Machine Code

You can see the machine code being hand assembled, entered and run in the following video:

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/qlZF1oGgnio" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
