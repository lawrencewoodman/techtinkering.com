If we are writing 6502 machine code and want to to create a routine or program that can be placed in any location then we have to create _Position Independent Code (PIC)_ or make the code relocatable.  Here I'm going to show how to make our code  _Position Independent_.  There are three full examples near the end of the article which show how to put this altogether.

## Branches Instead of Jumps
One of the first things we can do is use branches instead of `JMP` to an absolute address where possible.  This is because branches jump to a relative address that will still be the same if the code moves.  A branch allows a relative jump to an address -127/+128 bytes from the current address.

To do something similar to a `BRA` (BRanch Always) we just need to force the condition before using one of the Branch instructions.  An easy one to use is `BVC` (Branch on oVerflow Clear) as the _oVerflow_ flag is only altered by the `ADC`, `BIT`, `CLV` and `SBC` instructions which makes it easy to keep track of.

The following absolute jump:

``` asm6502
            jmp label          ; 3 bytes, 3 cycles
            ...
            ...
label       nop
```

can easily be turned into a relative jump:

``` asm6502
            clv                ; 1 byte,  2 cycles
            bvc label          ; 2 bytes, 3-4 cycles (depending on page cross)
            ...
            ...
label       nop
```

Both jumps take 3 bytes of code, but we can see that the relative jump takes 2-3 more cycles to complete and therefore this is something to keep an eye on.  If you are sure that the _oVerflow_ flag is clear then you can omit the `CLV` and actually save 1 byte and only take 0-1 more cycles to complete.


## Indirect Jumps for Long Jumps

If the location we want to jump to is going to be further than -127/+128 bytes away then we can put the location we want to jump to in fixed memory address and then jump to that location indirectly.  We may want to do this using a data table as described further down the article.

To compare, here is an absolute `JMP`

``` asm6502
            jmp labelA                ; 3 bytes, 3 cycles
```

Here is an indirect `JMP` using a data table with ILABELA as an index.  We can see that there is a 2 cycle overhead per `JMP`.

``` asm6502
            jmp (DATA_TABLE+ILABELA)  ; 3 bytes, 5 cycles
```

## A Data Table to Access Memory Indirectly

To access memory locations that would move with the code we can create a data table in a static location that contains pointers to each location in the code.  This would be accessed via an index using indirect addressing.


Here is a '_Hello, World!_' routine that uses a static location for `helloMsg` which we will convert in the second piece of code to become _Position Independent_ by using a data table.
``` asm6502
CCHROUT    = $FFD2             ; Output character to current output device

helloMsg   .asc "HELLO, WORLD!" : .byt CHR_RTN : .byt 0

            ; Non position independent
SayHello    .(
            ; Output message
            ldy #$00
loop        lda helloMsg, y               ; 3 bytes, 4-5 cycles (depending on page cross)
            beq finished
            jsr CCHROUT                   ; Output char to screen
            iny
            bne loop
finished    rts
.)
```

<br />

The following _Hello World_ routine adapts the one above and makes it _Position Independent_ by looking up the address of `helloMsg` in `DATA_TABLE` using `IHELLOMSG` as an index and storing it in `TMP_DPTR`.  `TMP_DPTR` is then accessed using indirect addressing by `LDA`.  `DATA_TABLE` is located in the cassette buffer at `$0334`.

``` asm6502
CHR_RTN    = $0D               ; Return character
CCHROUT    = $FFD2             ; Output character to current output device
TMP_DPTR   = $FB               ; Temporary data pointer
DATA_TABLE = $0334             ; The location of the data table
IHELLOMSG  = 0                 ; Index to 'HELLO, WORLD!' message

helloMsg   .asc "HELLO, WORLD!" : .byt CHR_RTN : .byt 0

            ; Position Independent
SayHello    .(
            ; Point TMP_DPTR to helloMsg
            lda DATA_TABLE+IHELLOMSG      ; 3 bytes, 4 cycles
            sta TMP_DPTR                  ; 2 bytes, 3 cycles
            lda DATA_TABLE+IHELLOMSG+1    ; 3 bytes, 4 cycles
            sta TMP_DPTR+1                ; 2 bytes, 3 cycles

            ; Output message
            ldy #$00
loop        lda (TMP_DPTR), y             ; 2 bytes, 5-6 cycles (depending on page cross)
            beq finished
            jsr CCHROUT                   ; Output char to screen
            iny
            bne loop
finished    rts
.)
```

If we compare the two routines we can see that there is an 8 byte overhead for the _PIC_ using a data table and a 15 cycle overhead.  This is in addition to the overhead of creating the data table in the first place.

## A Jump Table for Subroutine Calls
The `JSR` (Jump to Subroutine) instruction can only jump to absolute addresses.  One easy way to overcome this is to use a jump table.  This will contain a series of jumps to the correct location for each subroutine.

The jump table would contain code such as the following:

``` asm6502
CPRINTSCORE   jmp  $1420
CPRINTLIVES   jmp  $1430
CSHIPLEFT     jmp  $1440
CSHIPRIGHT    jmp  $1460
```

Then all the _PIC_ would do is `JSR` to one of the locations in the jump table which would then jump to the location of the subroutine.  E.g. if a game contained _PIC_ that wanted to move the ship left it would run the following:

``` asm6502
              jsr CSHIPLEFT
```

The jump table would have to be placed in a static location unless self-modifying code is used.  One possible location for the jump table could be at _$02A1-02FF_ which is reserved for program indirects.  This would be enough room for a jump table containing 31 jumps.

The extra `JMP` instruction adds a 3 cycle overhead to every `JSR` instruction. This is in addition to the overhead of creating the jump table in the first place.


## Getting the Program Counter

There are few situations where we would need to get the Program Counter because we could just get the address of the start of the code from the loader.  However, in case a situation arises or just for curiosity we can get the address of the _Program Counter_ with the code that follows.  This code should be copied to a static address, such as the cassette buffer, and `JSR` should call it to put the address of the calling `JSR` in `PC`.

``` asm6502
PC        = $09                ; Location to store PC in

            ; Put address of calling JSR into PC
GetPC       .(
            pla
            sta PC             ; Store the 16-bit program counter at PC
            pla
            sta PC+1
            pha                ; Restore the return address to the stack
            lda PC
            pha
            bne decL1          ; Decrement PC by 2 to point to calling instruction
            dec PC+1
decL1       dec PC
            bne decL2
            dec PC+1
decL2       dec PC
            rts
.)
```

This works because `JSR` puts the PC+2 onto the stack and `RTS` takes two bytes from the stack, increments them and jumps to this address.

## Calculating Absolute Addresses
To access data and run subroutines we need to calculate absolute addresses for them.  This can be done by using offsets from a certain point in the code and adding them to that point once its absolute addresses has been determined.  The absolute address of our reference point could be supplied by the machine code loader or sought using the `GetPC` routine above.

The following code shows how the absolute address used in a data table could be calculated to refer to a region of memory containing a _Hello, World_ message.

``` asm6502
CHR_RTN    = $0D               ; Return character

PC         = $09               ; Location to store PC in
DATA_TABLE = $0334             ; The location of the data table
IHELLOMSG  = 0                 ; Index to 'HELLO, WORLD!' message

            * = $1001

start       jsr GetPC          ; Put absolute address of start in PC

            ; BRanch Always
            clv
            bvc makeDTable

helloMsg   .asc "HELLO, WORLD!" : .byt CHR_RTN : .byt 0

            ; Make data table
makeDTable  clc
            lda PC
            adc #<(helloMsg-start)      ; LSB of offset from start
            sta DATA_TABLE+IHELLOMSG
            lda PC+1
            adc #>(helloMsg-start)      ; MSB of offset from start
            sta DATA_TABLE+IHELLOMSG+1
```

## Self-Modifying Code

We can avoid the use of jump tables and data tables by using self-modifying code.  This can create quicker, smaller and more readable code, but it isn't possible to do this if the code is located in ROM.

To create self-modifying code we can create a table which contains address offsets to change.  The address offsets will be offset from a location in the code and at run-time the values at these addresses will be changed to absolute addresses.


``` asm6502
TXTTAB     = $2B               ; Pointer to start of tokenized Basic
SMADDR     = $09               ; Address to modify
PSMTABLE   = $FB               ; Pointer to self-modification table
CHR_RTN    = $0D               ; Return character


            ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            ; Code has been removed here to create a
            ; Basic stub with first byte of stub
            ; labeled 'start'.  Where the stub is
            ; loaded can be found by looking at
            ; TXTTAB.
            ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

            ;=========================================
            ; Start of machine language
            ;=========================================
mLang
            * = mLang-start

            ; BRanch Always
            clv
            bvc setupSM

            ;-----------------------------------------
            ; Message strings
            ;-----------------------------------------
helloMsg   .asc "HELLO, WORLD!" : .byt CHR_RTN : .byt 0
byeMsg     .asc "GOODBYE, WORLD!" : .byt CHR_RTN : .byt 0

            ;=========================================
            ; Self-modification
            ;=========================================

            ;-----------------------------------------
            ; Self-modification table
            ; offsetAddr
            ;-----------------------------------------
smTable     .word main+1       ; Address of SayHello routine
            .word main+4       ; Address of SayGoodbye routine
            .word SayHello+3   ; Entry within SayHello
                               ; routine pointing to helloMsg
            .word SayGoodbye+3 ; Entry within SayGoodbye
                               ; routine pointing to byeMsg
            .word 0            ; End of table

            ;-----------------------------------------
            ; Self-modify code to point to correct
            ; locations
            ;-----------------------------------------

setupSM     .(
            ; Create pointer to smTable
            clc
            lda TXTTAB         ; Get start of tokenized Basic
            adc #<smTable
            sta PSMTABLE
            lda TXTTAB+1
            adc #>smTable
            sta PSMTABLE+1

            ; Point offsets in smTable to absolute addresses
            ldy #00
            lda (PSMTABLE), y
loop       ; Calculate address to change
            clc
            adc TXTTAB
            sta SMADDR
            iny
            lda TXTTAB+1
            adc (PSMTABLE), y
            iny
            sta SMADDR+1
            ; Move value at address
            tya
            tax
            ldy #00
            clc
            lda TXTTAB
            adc (SMADDR), y
            sta (SMADDR), y
            iny
            lda TXTTAB+1
            adc (SMADDR), y
            sta (SMADDR), y
            txa
            tay
            lda (PSMTABLE), y
            bne loop           ; If not end of table
.)

            ;=========================================
            ; MAIN program
            ;=========================================
main        jsr SayHello
            jsr SayGoodbye
            rts
```

## Video Demonstrating Position Independent Code

You can see _Position Independent Code_ explained and run in the following video:

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/qil0QJO_5xo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>


## Full Examples

The examples have been written for the [XA](https://www.floodgap.com/retrotech/xa/) assembler and are hosted on GitHub: [position_independent_code_vic20](https://github.com/lawrencewoodman/position_independent_code_vic20).

### Position Independent Code Without Self-Modification

The code below demonstrates creating a jump and data table to point to the subroutines and their associated message data.  The code contains a [Basic stub](/articles/adding-basic-stubs-to-assembly-language-on-the-commodore-vic-20/ "Adding Basic Stubs to Assembly Language on the Commodore VIC-20") to make the code easier to load and test.  It relies on location _$2B/$2C_ (`TXTAB`) pointing to the start of tokenized Basic so that it can use this as a reference point to calculate the absolute addresses in the rest of the code.  The start of tokenized Basic will change depending on the memory configuration of the Vic, but the machine language code will work regardless because it is _Position Independent_.

``` asm6502
; Basic Stub
OPEN_PR    = $28               ; ( character
CLOSE_PR   = $29               ; ) character
PLUS       = $AA               ; + character
TIMES      = $AC               ; * character
TOK_PEEK   = $C2               ; PEEK token
TOK_SYS    = $9E               ; SYS token

CHR_RTN    = $0D               ; Return character
OP_JMPA    = $4C               ; JMP absolute opcode
TXTTAB     = $2B               ; Pointer to start of tokenized Basic
CCHROUT    = $FFD2             ; Output character to current output device

TMP_DPTR   = $FB               ; Temporary data pointer
JMP_TABLE  = $02A1             ; The location of the jump table
DATA_TABLE = $0334             ; The location of the data table
IHELLOMSG  = 0                 ; Index to 'HELLO, WORLD!' message
IBYEMSG    = IHELLOMSG+2       ; Index to 'GOODBYE, WORLD!' message
CSAYHELLO  = JMP_TABLE         ; Vector to SayHello
CSAYBYE    = JMP_TABLE+3       ; Vector to SayGoodbye


            .byt $01, $80      ; Load Address.  Using character ROM because
                               ; correct RAM location memory configuration
                               ; dependent


            ;=========================================
            ;  Basic Stub
            ;=========================================

            ; 2020 SYS PEEK(43)+PEEK(44)*256+27
            * = $1001
start       .word basicEnd     ; Next Line link, here end of Basic program
            .word 2020         ; The line number for the SYS statement
            .byt  TOK_SYS      ; SYS token
            .asc  " "
            .byt  TOK_PEEK     ; PEEK token
            .byt  OPEN_PR      ; (
            .asc  "43"         ; 43
            .byt  CLOSE_PR     ; )
            .byt  PLUS         ; +
            .byt  TOK_PEEK     ; PEEK token
            .byt  OPEN_PR      ; (
            .asc  "44"         ; 44
            .byt  CLOSE_PR     ; )
            .byt  TIMES        ; *
            .asc  "256"        ; 256
            .byt  PLUS         ; +
            .asc  "27"         ; 27 (The size of the stub)
            .byt  0            ; End of Basic line
basicEnd    .word 0            ; End of Basic program


            ;=========================================
            ; Start of machine language
            ;=========================================

            ; BRanch Always
            clv
            bvc makeJTable

            ;-----------------------------------------
            ; Message strings
            ;-----------------------------------------
helloMsg   .asc "HELLO, WORLD!" : .byt CHR_RTN : .byt 0
byeMsg     .asc "GOODBYE, WORLD!" : .byt CHR_RTN : .byt 0


            ;=========================================
            ; Create jump and data tables
            ;=========================================

            ;-----------------------------------------
            ; Create jump table
            ;-----------------------------------------

            ; Store JMP absolute opcodes
makeJTable  lda #OP_JMPA       ; JMP absolute opcode
            sta CSAYHELLO
            sta CSAYBYE

            ; Jump table address for SayHello
            clc
            lda TXTTAB         ; Get start of tokenized Basic
            adc #<(SayHello-start)
            sta CSAYHELLO+1
            lda TXTTAB+1
            adc #>(SayHello-start)
            sta CSAYHELLO+2

            ; Jump table address for SayGoodbye
            clc
            lda TXTTAB         ; Get start of tokenized Basic
            adc #<(SayGoodbye-start)
            sta CSAYBYE+1
            lda TXTTAB+1
            adc #>(SayGoodbye-start)
            sta CSAYBYE+2

            ;-----------------------------------------
            ; Create data table
            ;-----------------------------------------

            ; Point entry at index IHELLOMSG to helloMsg
            clc
            lda TXTTAB         ; Get start of tokenized Basic
            adc #<(helloMsg-start)
            sta DATA_TABLE+IHELLOMSG
            lda TXTTAB+1
            adc #>(helloMsg-start)
            sta DATA_TABLE+IHELLOMSG+1

            ; Point entry at index IBYEMSG to byeMsg
            clc
            lda TXTTAB         ; Get start of tokenized Basic
            adc #<(byeMsg-start)
            sta DATA_TABLE+IBYEMSG
            lda TXTTAB+1
            adc #>(byeMsg-start)
            sta DATA_TABLE+IBYEMSG+1


            ;=========================================
            ; MAIN program
            ;=========================================
            jsr CSAYHELLO
            jsr CSAYBYE
            rts


            ;=========================================
            ; Subroutines
            ;=========================================

            ;-----------------------------------------
            ; SayHello
            ; Displays 'HELLO, WORLD!' message
            ;-----------------------------------------
SayHello    .(
            ; Point TMP_DPTR to helloMsg
            lda DATA_TABLE+IHELLOMSG
            sta TMP_DPTR
            lda DATA_TABLE+IHELLOMSG+1
            sta TMP_DPTR+1

            ; Output message
            ldy #$00
loop        lda (TMP_DPTR), y
            beq finished
            jsr CCHROUT        ; Output char to screen
            iny
            bne loop
finished    rts
.)

            ;-----------------------------------------
            ; SayGoodbye
            ; Displays 'GOODBYE, WORLD!' message
            ;-----------------------------------------
SayGoodbye  .(
            ; Point TMP_DPTR to byeMsg
            lda DATA_TABLE+IBYEMSG
            sta TMP_DPTR
            lda DATA_TABLE+IBYEMSG+1
            sta TMP_DPTR+1

            ; Output message
            ldy #$00
loop        lda (TMP_DPTR), y
            beq finished
            jsr CCHROUT        ; Output char to screen
            iny
            bne loop
finished    rts
.)
```

### Position Independent Code Using Self-Modification

This example also uses a [Basic stub](/articles/adding-basic-stubs-to-assembly-language-on-the-commodore-vic-20/ "Adding Basic Stubs to Assembly Language on the Commodore VIC-20") and the `TXTTAB` location mentioned in the previous example.  We can see that the code below is shorter, easier to read and would run faster once the self-modification had been completed.  However, self modifying code can't be placed in ROM.


``` asm6502
; Basic Stub
OPEN_PR    = $28               ; ( character
CLOSE_PR   = $29               ; ) character
PLUS       = $AA               ; + character
TIMES      = $AC               ; * character
TOK_PEEK   = $C2               ; PEEK token
TOK_SYS    = $9E               ; SYS token

; Self Modification
TXTTAB     = $2B               ; Pointer to start of tokenized Basic
SMADDR     = $09               ; Address to modify
PSMTABLE   = $FB               ; Pointer to self-modification table

; Character output
CHR_RTN    = $0D               ; Return character
CCHROUT    = $FFD2             ; Output character to current output device


            .byt $01, $80      ; Load Address.  Using character ROM because
                               ; correct RAM location memory configuration
                               ; dependent


            ;=========================================
            ;  Basic Stub
            ;=========================================
            * = $1001

            ; 2020 SYS PEEK(43)+PEEK(44)*256+27
start       .word basicEnd     ; Next Line link, here end of Basic program
            .word 2020         ; The line number for the SYS statement
            .byt  TOK_SYS      ; SYS token
            .asc  " "
            .byt  TOK_PEEK     ; PEEK token
            .byt  OPEN_PR      ; (
            .asc  "43"         ; 43
            .byt  CLOSE_PR     ; )
            .byt  PLUS         ; +
            .byt  TOK_PEEK     ; PEEK token
            .byt  OPEN_PR      ; (
            .asc  "44"         ; 44
            .byt  CLOSE_PR     ; )
            .byt  TIMES        ; *
            .asc  "256"        ; 256
            .byt  PLUS         ; +
            .asc  "27"         ; 27 (The size of the stub)
            .byt  0            ; End of Basic line
basicEnd    .word 0            ; End of Basic program


            ;=========================================
            ; Start of machine language
            ;=========================================
mLang
            * = mLang-start

            ; BRanch Always
            clv
            bvc setupSM

            ;-----------------------------------------
            ; Message strings
            ;-----------------------------------------
helloMsg   .asc "HELLO, WORLD!" : .byt CHR_RTN : .byt 0
byeMsg     .asc "GOODBYE, WORLD!" : .byt CHR_RTN : .byt 0


            ;=========================================
            ; Self-modification
            ;=========================================

            ;-----------------------------------------
            ; Self-modification table
            ; offsetAddr
            ;-----------------------------------------
smTable     .word main+1
            .word main+4
            .word SayHello+3
            .word SayGoodbye+3
            .word 0            ; End of table

            ;-----------------------------------------
            ; Self-modify code to point to correct
            ; locations
            ;-----------------------------------------

setupSM     .(
            ; Create pointer to smTable
            clc
            lda TXTTAB         ; Get start of tokenized Basic
            adc #<smTable
            sta PSMTABLE
            lda TXTTAB+1
            adc #>smTable
            sta PSMTABLE+1

            ; Skip self-modication if has already been run
            ; This isn't needed if sure code will only be run once
            ldy #01
            lda (PSMTABLE), y
            cmp #$FF           ; Page $FF indicates SM already run
            beq main

            ; Point offsets in smTable to absolute addresses
            ldy #00
            lda (PSMTABLE), y
loop       ; Calculate address to change
            clc
            adc TXTTAB
            sta SMADDR
            iny
            lda TXTTAB+1
            adc (PSMTABLE), y
            iny
            sta SMADDR+1
            ; Move value at address
            tya
            tax
            ldy #00
            clc
            lda TXTTAB
            adc (SMADDR), y
            sta (SMADDR), y
            iny
            lda TXTTAB+1
            adc (SMADDR), y
            sta (SMADDR), y
            txa
            tay
            lda (PSMTABLE), y
            bne loop           ; If not end of table

            ; Record that self-modification has been run
            ; by setting page of first address to $FF
            ldy #01
            lda #$FF
            sta (PSMTABLE), y
.)

            ;=========================================
            ; MAIN program
            ;=========================================
main        jsr SayHello
            jsr SayGoodbye
            rts


            ;=========================================
            ; Subroutines
            ;=========================================

            ;-----------------------------------------
            ; SayHello
            ; Displays 'HELLO, WORLD!' message
            ;-----------------------------------------
SayHello    .(
            ; Output message
            ldy #$00
loop        lda helloMsg, y
            beq finished
            jsr CCHROUT        ; Output char to screen
            iny
            bne loop
finished    rts
.)

            ;-----------------------------------------
            ; SayGoodbye
            ; Displays 'GOODBYE, WORLD!' message
            ;-----------------------------------------
SayGoodbye  .(
            ; Output message
            ldy #$00
loop        lda byeMsg, y
            beq finished
            jsr CCHROUT        ; Output char to screen
            iny
            bne loop
finished    rts
.)
```

### Position Independent Code Getting Absolute Address of Point in Code

The last example shows how we can determine the absolute address of a point in the code from which we can calculate offsets.  The code works by creating a routine at _$02A1_ to get the Program Counter (`GetPC`).  Once an absolute address has been determined all the other addresses can be calculated in relation to that address.

This example doesn't use a Basic stub, but does specify address _$1203_ as its load address.  This address should work for all memory configurations.  To load and run it we could use:

``` basic
LOAD "*",8,1
SYS 4611
```

We can change the load address and as long as it's a valid area for our Vic and we `SYS` to the correct address, the code will work fine.

``` asm6502
; Opcodes
OP_BNE     = $D0               ; BNE
OP_DECA    = $CE               ; DEC absolute
OP_JMPA    = $4C               ; JMP absolute
OP_PHA     = $48               ; PHA
OP_PLA     = $68               ; PLA
OP_RTS     = $60               ; RTS
OP_LDAA    = $AD               ; LDA absolute
OP_STAA    = $8D               ; STA absolute

CHR_RTN    = $0D               ; Return character
CCHROUT    = $FFD2             ; Output character to current output device

PC         = $09               ; Location to store PC in
TMP_DPTR   = $FB               ; Temporary data pointer
JMP_TABLE  = $02A1             ; The location of the jump table
DATA_TABLE = $0334             ; The location of the data table
IHELLOMSG  = 0                 ; Index to 'HELLO, WORLD!' message
IBYEMSG    = IHELLOMSG+2       ; Index to 'GOODBYE, WORLD!' message
CSAYHELLO  = JMP_TABLE         ; Vector to SayHello
CSAYBYE    = JMP_TABLE+3       ; Vector to SayGoodbye

GetPC      = $02A1             ; Location of GetPC routine

            .byt $03, $12      ; Load Address.
                               ; $1203 should work for any memory configuration


            ;=========================================
            ; Static data
            ;=========================================
            * = $1203

            ; BRanch Always
            clv
            bvc start

            ;-----------------------------------------
            ; Message strings
            ;-----------------------------------------
helloMsg   .asc "HELLO, WORLD!" : .byt CHR_RTN : .byt 0
byeMsg     .asc "GOODBYE, WORLD!" : .byt CHR_RTN : .byt 0


            ;=========================================
            ; Determine Absolute address for start of
            ; code
            ;=========================================

            ;-----------------------------------------
            ;  Create GetPC at $02A1
            ;-----------------------------------------
start       lda #OP_PLA        ; PLA
            sta GetPC
            lda #OP_STAA       ; STA PC
            sta GetPC+1        ; - Store the 16-bit program counter at PC
            lda #<PC           ;
            sta GetPC+2
            lda #>PC
            sta GetPC+3
            lda #OP_PLA        ; PLA
            sta GetPC+4
            lda #OP_STAA       ; STA PC+1
            sta GetPC+5
            lda #<PC+1
            sta GetPC+6
            lda #>PC+1         ; Using MSB of PC in case moved out of zero page
            sta GetPC+7
            lda #OP_PHA        ; PHA
            sta GetPC+8        ; - Restore the return address to the stack
            lda #OP_LDAA       ; LDA PC
            sta GetPC+9
            lda #<PC
            sta GetPC+10
            lda #>PC
            sta GetPC+11
            lda #OP_PHA        ; PHA
            sta GetPC+12
            lda #OP_BNE        ; BNE decL1
            sta GetPC+13       ; - PC=PC-2 to point to calling instruction
            lda #$03
            sta GetPC+14
            lda #OP_DECA      ; DEC PC+1
            sta GetPC+15       ; - MSB
            lda #<PC+1
            sta GetPC+16
            lda #>PC+1
            sta GetPC+17
            lda #OP_DECA      ; decL1:  DEC PC
            sta GetPC+18       ; - LSB
            lda #<PC
            sta GetPC+19
            lda #>PC
            sta GetPC+20
            lda #OP_BNE        ; BNE decL2
            sta GetPC+21
            lda #$03
            sta GetPC+22
            lda #OP_DECA      ; DEC PC+1
            sta GetPC+23
            lda #<PC+1
            sta GetPC+24
            lda #>PC+1
            sta GetPC+25
            lda #OP_DECA      ; decL2:  DEC PC
            sta GetPC+26
            lda #<PC
            sta GetPC+27
            lda #>PC
            sta GetPC+28
            lda #OP_RTS        ; RTS
            sta GetPC+29

callGetPC   jsr GetPC          ; Get absolute address of callGetPC


            ;=========================================
            ; Create jump and data tables
            ;=========================================

            ;-----------------------------------------
            ; Create jump table
            ;-----------------------------------------

            ; Store JMP absolute opcodes
            lda #OP_JMPA       ; JMP absolute opcode
            sta CSAYHELLO
            sta CSAYBYE

            ; Jump table address for SayHello
            clc
            lda PC
            adc #<(SayHello-callGetPC)
            sta CSAYHELLO+1
            lda PC+1
            adc #>(SayHello-callGetPC)
            sta CSAYHELLO+2

            ; Jump table address for SayGoodbye
            clc
            lda PC
            adc #<(SayGoodbye-callGetPC)
            sta CSAYBYE+1
            lda PC+1
            adc #>(SayGoodbye-callGetPC)
            sta CSAYBYE+2

            ;-----------------------------------------
            ; Create data table
            ;-----------------------------------------

            ; Point entry at index IHELLOMSG to helloMsg
            clc
            lda PC
            adc #<(helloMsg-callGetPC)
            sta DATA_TABLE+IHELLOMSG
            lda PC+1
            adc #>(helloMsg-callGetPC)
            sta DATA_TABLE+IHELLOMSG+1

            ; Point entry at index IBYEMSG to byeMsg
            clc
            lda PC
            adc #<(byeMsg-callGetPC)
            sta DATA_TABLE+IBYEMSG
            lda PC+1
            adc #>(byeMsg-callGetPC)
            sta DATA_TABLE+IBYEMSG+1


            ;=========================================
            ; MAIN program
            ;=========================================
            jsr CSAYHELLO
            jsr CSAYBYE
            rts


            ;=========================================
            ; Subroutines
            ;=========================================

            ;-----------------------------------------
            ; SayHello
            ; Displays 'HELLO, WORLD!' message
            ;-----------------------------------------
SayHello    .(
            ; Point TMP_DPTR to helloMsg
            lda DATA_TABLE+IHELLOMSG
            sta TMP_DPTR
            lda DATA_TABLE+IHELLOMSG+1
            sta TMP_DPTR+1

            ; Output message
            ldy #$00
loop        lda (TMP_DPTR), y
            beq finished
            jsr CCHROUT        ; Output char to screen
            iny
            bne loop
finished    rts
.)

            ;-----------------------------------------
            ; SayGoodbye
            ; Displays 'GOODBYE, WORLD!' message
            ;-----------------------------------------
SayGoodbye  .(
            ; Point TMP_DPTR to byeMsg
            lda DATA_TABLE+IBYEMSG
            sta TMP_DPTR
            lda DATA_TABLE+IBYEMSG+1
            sta TMP_DPTR+1

            ; Output message
            ldy #$00
loop        lda (TMP_DPTR), y
            beq finished
            jsr CCHROUT        ; Output char to screen
            iny
            bne loop
finished    rts
.)
```
