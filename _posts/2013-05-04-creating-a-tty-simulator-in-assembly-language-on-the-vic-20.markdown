---
layout: article
title: "Creating a TTY Simulator in Assembly Language on the Vic-20"
tags:
  - Programming
  - Retro
  - Commodore
  - Vic-20
  - Assembly
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

The Vicmon machine language cartridge is an excellent tool for exploring the Vic-20.  This article and its associated video will show you how to use it to create a simple program that will change the normal output of a Vic so that it feels a bit like a teletype terminal.  This will be done by taking over some of the functionality of the KERNEL's _CHROUT_ subroutine at `$FFD2`.  For those without an easy way of entering an assembly language program, there is a BASIC listing at the end.

Assuming you have the Vicmon cartridge attached to your machine or emulator, you can now enter the monitor.  If you are not too familiar with the Vicmon cartridge, have a look at: [Beginning Assembly Programming on the Vic-20](/2013/04/16/beginning-assembly-programming-on-the-commodore-vic-20/).

    SYS 24576

Each KERNAL subroutine is actually just a jump table to somewhere else.  To see where the _CHROUT_ subroutine jumps to, we'll disassemble the code at `$FFD2`:

    .D FFD2

Which shows that it contains:

    FFD2 JMP ($0326)

This is an indirect jump to the address stored at `$0326`.

If we now look at `$0326`:

    .M 0326

We see that the first two bytes are `7A F2`.  The 6502 is little-endian, so it stores the least significant byte first and hence this is address `$F27A`.  Because `$0326` is in RAM, we can change the address there to point to our code.  Once our routine has been run, we'll jump to `$F27A` to output the character to screen.

It would be better if our program doesn't interfere with BASIC, so as it is quite small, we can store it in the cassette buffer.  This is located at `$033C` and is 191 bytes long.  If you load or save with the cassette, the program will naturally be lost.

The program is essentially in two parts.  The first part changes the output vector to point to the second part and sets the volume to maximum.  The second part is the routine which will be called when the _CHROUT_ (`$FFD2`) subroutine jumps to the output vector stored at `$0326`.  This part will output a noise, pause and then jump to the original output vector at `$F27A`.

The video below shows how to use the Vicmon machine language cartridge to enter the program and demonstrates the TTY effect.

<object style="margin-top: 1em; margin-right:1em; margin-bottom:1em;" align="left" width="650" height="394">
  <param name="movie" value="http://www.youtube.com/v/kmvF85euefs&amp;hl=en&amp;fs=1"></param>
  <param name="allowFullScreen" value="true"></param>
  <param name="allowscriptaccess" value="always"></param>
  <embed src="http://www.youtube.com/v/kmvF85euefs&amp;hl=en&amp;fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="650" height="394"></embed>
</object>

## Disassembly of Program
Here is the full program as entered in the video, so that you can play with it yourself.

          ; Initialize the routine
    033C  LDA #$03      ; Point output vector used by $FFD2 to our routine
    033E  STA $0327     ; |
    0341  LDA #$4C      ; |
    0343  STA $0326     ; \
    0346  LDA #$0F      ; Set the volume to maximum
    0348  STA $900E     ; \
    034B  RTS

          ; The main routine pointed to by the output vector
    034C  PHA           ; Save the character to be printed

    034D  CMP #$20      ; Skip making a noise if a space character
    034F  BEQ $035A     ; \
    0351  CMP #$0D      ; Skip making a noise if a return character
    0353  BEQ $035A     ; \

    0355  LDA #$80      ; Make the lowest note possible with speaker 2
    0357  STA $900B     ; \

    035A  TXA           ; Save the registers because $FFD2 doesn't alter them
    035B  PHA           ; |
    035C  TYA           ; |
    035D  PHA           ; \

    035E  LDY #$00      ; Delay to hold note if making a noise or give equal gap
    0360  LDX #$15      ; |
    0362  DEY           ; |
    0363  BNE $0362     ; |
    0365  DEX           ; |
    0366  BNE $0362     ; \

    0368  LDA #$00      ; Turn off speaker 2
    036A  STA $900B     ; \

    036D  LDY #$00      ; Delay between letters
    036F  LDX #$10      ; |
    0371  DEY           ; |
    0372  BNE $0371     ; |
    0374  DEX           ; |
    0375  BNE $0371     ; \

    0377  PLA           ; Restore the registers
    0378  TAY           ; |
    0379  PLA           ; |
    037A  TAX           ; |
    037B  PLA           ; \

    037C  JMP $F27A     ; Jump to the normal output vector stored in $0326

## Memory Dump
Below is a memory dump of the program.  Some find it quicker to enter the hex codes directly and this is also useful to create a BASIC program that will load the machine language.

    033C  A9 03 8D 27 03
    0341  A9 4C 8D 26 03
    0346  A9 0F 8D 0E 90
    034B  60 48 C9 20 F0
    0350  09 C9 0D F0 05
    0355  A9 80 8D 0B 90
    035A  8A 48 98 48 A0
    035F  00 A2 15 88 D0
    0364  FD CA D0 FA A9
    0369  00 8D 0B 90 A0
    036E  00 A2 10 88 D0
    0373  FD CA D0 FA 68
    0378  A8 68 AA 68 4C
    037D  7A F2

I find it quite nice to work with the hex as well as assembly language, particularly when you are debugging as it can be quicker to navigate and find what you are looking for.  Here you can see the repeated `LDA` commands used at the start of the program as `A9`.  You can also see the `20` used to detect a space at `$034E`.  If you wanted to change this character, you could just alter that memory location, instead of reassembling the line.

## BASIC Alternative

The following is the program converted to BASIC so that anyone with a Vic can enter it.

    10 FOR ADR=828 TO 894:READ OCT:POKE ADR,OCT:NEXT ADR
    20 DATA 169,3,141,39,3,169,76,141,38,3
    30 DATA 169,15,141,14,144,96,72,201,32,240
    40 DATA 9,201,13,240,5,169,128,141,11,144
    50 DATA 138,72,152,72,160,0,162,21,136,208
    60 DATA 253,202,208,250,169,0,141,11,144,160
    70 DATA 0,162,16,136,208,253,202,208,250,104
    80 DATA 168,104,170,104,76,122,242
    90 SYS 828

All you have to do is `RUN` the program and from that point on your Vic will feel a bit like a TTY.

## Where now?
For more information on Vicmon or for those just starting to program the Vic-20 in assembly language, take a look at: [Beginning Assembly Programming on the Vic-20](/2013/04/16/beginning-assembly-programming-on-the-commodore-vic-20/).  I have also created an extended version of the TTY simulator and hosted it on GitHub: [vic20_simtty](https://github.com/LawrenceWoodman/vic20_simtty).
