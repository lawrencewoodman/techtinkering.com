---
layout: article
title: "Adding a Basic Stub to a Vic-20 Assembly Language Program"
tags:
  - Programming
  - Retro
  - Tutorial
  - Commodore
  - Vic-20
  - Assembly
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

To make machine language programs more friendly it is nice to add a basic stub which contains a line with a `SYS` statement to start the code.  This is easy to do on the Vic-20 and the process gives you an insight into how Basic programs are stored in memory.  I'll show you how to do this and how to extend the programs to meet your needs.

A Basic program consists of a series of Basic lines followed by two `00` octets to signify the end of the program.  Each Basic line starts with a 16-bit next line link to the next Basic line in memory. Then there is a 16-bit Basic line number.  The following bytes represents the statements on the Basic line and is terminated by a `00` octet.

To create the following Basic program:

    2013 SYS 4110

We could use this simple Basic stub for an unexpanded Vic in [xa65](http://www.floodgap.com/retrotech/xa/) assembler:

                * = $1001
                .word basicEnd    ; Next Line link, here end of Basic program
                .word 2013        ; The line number for the SYS statement
                .byt  $9e         ; SYS token
                .asc  " "
                .asc  "4110"      ; Start of machine language
                .byt  0           ; End of Basic line
    basicEnd    .word 0           ; End of Basic program


The location `4110` is the next memory address after the end of the Basic program.  The Basic program starts at memory location `$1001` which is `4097` in decimal, and the Basic stub is `13` bytes long, so `4097 + 13 = 4110`.


## Using Vicmon to Explore a Basic Program
To see how the Vic-20 stores a BASIC program in memory we can use the Vicmon Cartridge, introduced [previously](/2013/04/16/beginning-assembly-programming-on-the-commodore-vic-20/ "Beginning Assembly Programming on the Commodore Vic-20").  First power cycle your Vic and enter the following program:

    2013 SYS 4110

On an unexpanded Vic-20 the User Basic Area is at $1000 and a Basic program begins at $1001.  If we enter the monitor and look at the program:

    .M 1001 100F

We'll see

    1001 0C 10 DD 07 9E
    1006 20 34 31 31 30
    100B 00 00 00 00 00

The first two bytes `0C 10` is an address, `$100C`, representing the next line of Basic in memory, in this case it points to `00 00` which signifies the end of the program.

The second two bytes `DD 07` is the number `$07DD` which when converted to decimal is `2013`.  So this is the line number of the first line.

We now have the actual contents of the Basic line.  It starts with `9E` which is the token for `SYS`, followed by `20` which is a space character.  Then come four bytes `34 31 31 30`, which are the ASCII characters `4110`.  The line is terminated by the octet `00`.

Finally the end of the program is marked by `00 00`.


## Hiding the SYS Statement With a Message
When you load many programs and do a `LIST`, all you see is a message such as:

    (C) 2013 LORRY WOODMAN

This is done by following the `SYS` statement with a `REM` containing backspace characters, which would look like:

                * = $1001
                .word basicEnd    ; Next Line link, here end of BASIC program
                .word 1           ; The line number for the SYS statement
                .byt  $9e         ; SYS token
                .asc  " "
                .asc  "4150"      ; Start of machine language
                .byt  $3a         ; colon symbol token
                .byt  $8f         ; REM token
                .asc  " "
                .dsb  15,$14      ; Backspace characters to make line invisible
                .asc  "(C) 2013 LORRY WOODMAN"
                .byt  0           ; End of Basic line
    basicEnd    .word 0           ; End of Basic program

To calculate the start of machine language add the number of bytes in the message to `4128`.  In the example above the message is `22` bytes long, hence the start of the machine language code is at `4150`.

## More Complex Basic Stubs
For more complex Basic stubs, rather than working out each byte of the stub by hand, I would recommend creating the Basic program that you want, and then examining it with a machine language monitor.  This way you can easily see what is happening and then just copy the memory dump when you are happy with the program.

Some values will be unknown to you when you write the Basic program, so just put in a dummy value with the right number of characters and use the monitor to work out what the correct value should be.  A good example of this is working out where a `SYS` statement should point to.  I would enter `8888`, then look in the monitor for `38 38 38 38` and change those values to the next memory location after the end of the Basic program as indicated in the monitor.

## Other Memory Configurations
There are three main memory configurations that you have to be aware of with the Vic: unexpanded, 3Kb memory expansion and 8Kb or more memory expansion.  The following table translates the main values used above to the correct value for each configuration:

<table class="neatTable">
  <tr><th>Unexpanded</th><th>3Kb</th><th>8Kb+</th></tr>
  <tr><td>4097 / $1001</td><td>1025 / $401</td><td>4609 / $1201</td></tr>
  <tr><td>4110</td><td>1038</td><td>4622</td></tr>
  <tr><td>4128</td><td>1056</td><td>4640</td></tr>
  <tr><td>4150</td><td>1078</td><td>4662</td></tr>
</table>

So the first Basic stub would look like the following for a 3Kb configuration:

                ; 2013 SYS 1038
                * = $401
                .word basicEnd    ; Next Line link, here end of Basic program
                .word 2013        ; The line number for the SYS statement
                .byt  $9e         ; SYS token
                .asc  " "
                .asc  "1038"      ; Start of machine language
                .byt  0           ; End of Basic line
    basicEnd    .word 0           ; End of Basic program

And for an 8Kb+ configuration:

                ; 2013 SYS 4622
                * = $1201
                .word basicEnd    ; Next Line link, here end of Basic program
                .word 2013        ; The line number for the SYS statement
                .byt  $9e         ; SYS token
                .asc  " "
                .asc  "4622"      ; Start of machine language
                .byt  0           ; End of Basic line
    basicEnd    .word 0           ; End of Basic program

## Putting it All Together
To finish, here is a complete program including a Basic stub, which has been added to the "Hello, World!" example from: [Beginning Assembly Programming on the Commodore Vic-20](/2013/04/16/beginning-assembly-programming-on-the-commodore-vic-20).


    CHROUT  =   $ffd2

                * = $1001
                .word basicEnd    ; Next Line link, here end of Basic program
                .word 2013        ; The line number for the SYS statement
                .byt  $9e         ; SYS token
                .asc  " "
                .asc  "4110"      ; Start of machine language
                .byt  0           ; End of Basic line
    basicEnd    .word 0           ; End of Basic program

                ldx #$00
    loop        lda message, x
                beq finished
                jsr CHROUT
                inx
                bne loop
    finished    rts

    message     .asc "HELLO, WORLD!" : .byt 0
