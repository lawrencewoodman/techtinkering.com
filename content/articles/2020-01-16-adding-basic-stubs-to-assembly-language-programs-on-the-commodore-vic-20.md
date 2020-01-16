To make machine language programs more friendly it's nice to add a Basic stub which contains a line with a `SYS` statement to start the code.  This is easy to do on the VIC-20 and the process gives you an insight into how Basic programs are stored in memory.

A Basic program consists of a series of Basic lines followed by two `00` octets to signify the end of the program.  Each Basic line starts with a 16-bit next line link to the next Basic line in memory. Then there is a 16-bit Basic line number.  The following bytes represents the statements on the Basic line and is terminated by a `00` octet.

To create the following Basic program for an unexpanded Vic:
```` basic
2020 SYS 4110
````

We could use this simple Basic stub for an unexpanded Vic in [xa65](http://www.floodgap.com/retrotech/xa/) assembler.  The code contains a load address to make the output a valid .PRG file.

``` asm6502
TOK_SYS   = $9E               ; SYS token

            .byt  $01, $10    ; Load address ($1001)

            * = $1001
            .word basicEnd    ; Next Line link, here end of Basic program
            .word 2020        ; The line number for the SYS statement
            .byt  TOK_SYS     ; SYS token
            .asc  " "
            .asc  "4110"      ; Start of machine language
            .byt  0           ; End of Basic line
basicEnd    .word 0           ; End of Basic program
```


The location `4110` is the next memory address after the end of the Basic program on an unexpanded Vic.  The Basic program starts at memory location `$1001` which is `4097` in decimal, and the Basic stub is `13` bytes long, so `4097 + 13 = 4110`.


## Using Vicmon to Explore a Basic Program
To see how the Vic stores a Basic program in memory we can use the Vicmon Cartridge, introduced [previously](/2013/04/16/beginning-assembly-programming-on-the-commodore-vic-20/ "Beginning Assembly Programming on the Commodore Vic-20").  First power cycle your Vic and enter the following program:
``` basic
2020 SYS 4110
```

On an unexpanded Vic the User Basic Area is at $1000 and a Basic program begins at $1001.  If we enter the monitor and look at the program:
``` text
.M 1001 100F
```

We'll see
``` text
1001 0C 10 E4 07 9E
1006 20 34 31 31 30
100B 00 00 00 00 00
```

The first two bytes `0C 10` is an address, `$100C`, representing the next line of Basic in memory, in this case it points to `00 00` which signifies the end of the program.

The second two bytes `E4 07` is the number `$07E4` which when converted to decimal is `2020`.  So this is the line number of the first line.

We now have the actual contents of the Basic line.  It starts with `9E` which is the token for `SYS`, followed by `20` which is a space character.  Then come four bytes `34 31 31 30`, which are the ASCII characters `4110`.  The line is terminated by the octet `00`.

Finally the end of the program is marked by `00 00`.


## Hiding the SYS Statement With a Message
When you load many programs and do a `LIST`, all you see is a message such as:
```` text
(C) 2020 LORRY WOODMAN
````

This is done by following the `SYS` statement with a `REM` containing backspace characters, which would look like:
``` asm6502
BSPACE    = $14               ; Backspace character
COLON     = $3A               ; Colon character
TOK_REM   = $8F               ; REM token
TOK_SYS   = $9E               ; SYS token

            .byt  $01, $10    ; Load address ($1001)

            * = $1001
            .word basicEnd    ; Next Line link, here end of BASIC program
            .word 1           ; The line number for the SYS statement
            .byt  TOK_SYS     ; SYS token
            .asc  " "
            .asc  "4150"      ; Start of machine language
            .byt  COLON       ; Colon character
            .byt  TOK_REM     ; REM token
            .asc  " "
            .dsb  15,BSPACE   ; Backspace characters to make line invisible
            .asc  "(C) 2020 LORRY WOODMAN"
            .byt  0           ; End of Basic line
basicEnd    .word 0           ; End of Basic program
```

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
``` asm6502
TOK_SYS   = $9E               ; SYS token

            .byt  $01, $04    ; Load address ($0401)

            ; 2020 SYS 1038
            * = $401
            .word basicEnd    ; Next Line link, here end of Basic program
            .word 2020        ; The line number for the SYS statement
            .byt  TOK_SYS     ; SYS token
            .asc  " "
            .asc  "1038"      ; Start of machine language
            .byt  0           ; End of Basic line
basicEnd    .word 0           ; End of Basic program
```

And for an 8Kb+ configuration:
``` asm6502
TOK_SYS   = $9E               ; SYS token

            .byt  $01, $12    ; Load address ($1201)

            ; 2020 SYS 4622
            * = $1201
            .word basicEnd    ; Next Line link, here end of Basic program
            .word 2020        ; The line number for the SYS statement
            .byt  TOK_SYS     ; SYS token
            .asc  " "
            .asc  "4622"      ; Start of machine language
            .byt  0           ; End of Basic line
basicEnd    .word 0           ; End of Basic program
```


## Memory Configuration Independent

To create a stub that will work no matter what memory configuration the program is loaded into we need to calculate the start of the machine code for the `SYS` statement.  We can do this by examining location 43/44 which points to the start of tokenized Basic programs to create the following program, where 27 is the size of the Basic stub:

``` basic
2020 SYS PEEK(43)+PEEK(44)*256+27
```

In the code for the Basic stub below we don't need to worry about the value for `basicEnd` being wrong on expanded Vics as the value will be corrected by the Basic loader.

``` asm6502
OPEN_PR   = $28               ; ( character
CLOSE_PR  = $29               ; ) character
PLUS      = $AA               ; + character
TIMES     = $AC               ; * character
TOK_PEEK  = $C2               ; PEEK token
TOK_SYS   = $9E               ; SYS token

            .byt $01, $80     ; Load Address.  Using character ROM because
                              ; correct RAM location memory configuration
                              ; dependent

            ; 2020 SYS PEEK(43)+PEEK(44)*256+27
            * = $1001         ; Only used to give basicEnd a reasonable value
start       .word basicEnd    ; Next Line link, here end of Basic program
            .word 2020        ; The line number for the SYS statement
            .byt  TOK_SYS     ; SYS token
            .asc  " "
            .byt  TOK_PEEK    ; PEEK token
            .byt  OPEN_PR     ; (
            .asc  "43"        ; 43
            .byt  CLOSE_PR    ; )
            .byt  PLUS        ; +
            .byt  TOK_PEEK    ; PEEK token
            .byt  OPEN_PR     ; (
            .asc  "44"        ; 44
            .byt  CLOSE_PR    ; )
            .byt  TIMES       ; *
            .asc  "256"       ; 256
            .byt  PLUS        ; +
            .asc  "27"        ; 27 (The size of the stub)
            .byt  0           ; End of Basic line
basicEnd    .word 0           ; End of Basic program
```

It should be noted that the machine code that follows the Basic stub in this example will have to be made position independent as its start location will be unknown when the code is assembled.

## Putting it All Together
To finish, here is a complete program including a Basic stub, which has been added to the "Hello, World!" example from: [Beginning Assembly Programming on the Commodore Vic-20](/2013/04/16/beginning-assembly-programming-on-the-commodore-vic-20).

``` asm6502
BSPACE    = $14               ; Backspace character
COLON     = $3A               ; Colon character
TOK_REM   = $8F               ; REM token
TOK_SYS   = $9E               ; SYS token

CCHROUT   = $FFD2

            .byt  $01, $10    ; Load address ($1001)

            * = $1001
            .word basicEnd    ; Next Line link, here end of Basic program
            .word 2020        ; The line number for the SYS statement
            .byt  TOK_SYS     ; SYS token
            .asc  " "
            .asc  "4150"      ; Start of machine language
            .byt  COLON       ; Colon character
            .byt  TOK_REM     ; REM token
            .asc  " "
            .dsb  15,BSPACE   ; Backspace characters to make line invisible
            .asc  "(C) 2020 LORRY WOODMAN"
            .byt  0           ; End of Basic line
basicEnd    .word 0           ; End of Basic program

            ; Print 'HELLO, WORLD!"
            ldx #$00
loop        lda message, x
            beq finished
            jsr CCHROUT
            inx
            bne loop
finished    rts

message     .asc "HELLO, WORLD!" : .byt 0
```

## Video Demonstrating Basic Stubs

You can see the Basic stubs being investigated with Vicmon and implemented in the following video:

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/qLbFqbJtuhw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
