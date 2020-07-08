Sweet 16 was created by Steve Wozniak to reduce code size and make it easier to handle 16-bit pointers and arithmetic for his Apple Integer BASIC.  He wrote it around 1977 and referred to it in an article as _The 6502 Dream Machine_.  I have ported this to the Commodore VIC-20 so that we can play with it on the Vic.

## Outline of Sweet 16

Sweet 16 is described as a pseudo-machine interpreter, which is probably a better description than a virtual machine because it shares native memory for storage and is designed to switch back and forth between itself and native 6502 code.  The pseudo-machine has sixteen 16-bit registers with five of them having a defined function.


* R0 &nbsp; Accumulator
* R12 Subroutine return stack pointer
* R13 Comparison instruction results
* R14 Status register
* R15 Program counter

To execute Sweet 16 code you `JSR` to an address within it which will save the registers and status then execute the following bytes in memory as Sweet 16 code until it reaches the Sweet 16 `RTN` instruction which will restore the registers and status and continue executing the native 6502 that follows it.

The code is pretty compact and only takes around 300 bytes, it could have been made a little more compact and faster but it had to reside in ROM and therefore couldn't use self-modifying code.


### Instruction Set

<div class="overflow-auto"><table class="neatTable">
  <tr>
    <th colspan="3">Register Operations</th>
    <th colspan="3">Nonregister Operations</th>
  </tr>
  <tr>
    <td></td><td></td><td></td>
    <td>00</td><td>RTN</td><td>Return to 6502 mode</td>
  </tr>
  <tr>
    <td>1n</td><td>SET Rn</td><td>Constant set</td>
    <td>01</td><td>BR ea</td><td>Branch always</td>
  </tr>
  <tr>
    <td>2n</td><td>LD Rn</td><td>Load</td>
    <td>02</td><td>BNC ea</td><td>Branch if No Carry</td>
  </tr>
  <tr>
    <td>3n</td><td>ST Rn</td><td>Store</td>
    <td>03</td><td>BC ea</td><td>Branch if Carry</td>
  </tr>
  <tr>
    <td>4n</td><td>LD @Rn</td><td>Load indirect</td>
    <td>04</td><td>BP ea</td><td>Branch if Plus</td>
  </tr>
  <tr>
    <td>5n</td><td>ST @Rn</td><td>Store indirect</td>
    <td>05</td><td>BM ea</td><td>Branch if Minus</td>
  </tr>
  <tr>
    <td>6n</td><td>LDD @Rn</td><td>Load double indirect</td>
    <td>06</td><td>BZ ea</td><td>Branch if Zero</td>
  </tr>
  <tr>
    <td>7n</td><td>STD @Rn</td><td>Store double indirect</td>
    <td>07</td><td>BNZ ea</td><td>Branch if NonZero</td>
  </tr>
  <tr>
    <td>8n</td><td>POP @Rn</td><td>Pop indirect</td>
    <td>08</td><td>BM1 ea</td><td>Branch if Minus 1</td>
  </tr>
  <tr>
    <td>9n</td><td>STP @Rn</td><td>Store Pop indirect</td>
    <td>09</td><td>BNM1 ea</td><td>Branch if Not Minus 1</td>
  </tr>
  <tr>
    <td>An</td><td>ADD Rn</td><td>Add</td>
    <td>0A</td><td>BK</td><td>Break</td>
  </tr>
  <tr>
    <td>Bn</td><td>SUB Rn</td><td>Subtract</td>
    <td>0B</td><td>RS</td><td>Return from Subroutine</td>
  </tr>
  <tr>
    <td>Cn</td><td>POPD @Rn</td><td>Pop double indirect</td>
    <td>0C</td><td>BS ea</td><td>Branch to Subroutine</td>
  </tr>
  <tr>
    <td>Dn</td><td>CPR Rn</td><td>Compare</td>
    <td>0D</td><td colspan="2">Unassigned</td>
  </tr>
  <tr>
    <td>En</td><td>INR Rn</td><td>Increment</td>
    <td>0E</td><td>Unassigned</td>
  </tr>
  <tr>
    <td>Fn</td><td>DCR Rn</td><td>Decrement</td>
    <td>0F</td><td>Unassigned</td>
  </tr>
</table></div>

There is an implicit _Accumulator_ argument for most of the _Register Operations_ and the _Branch_ instructions all use _relative addressing_.  The instruction set is well thought out with the ability to use 8-bit bytes or 16-bit words and helpfully instructions like the indirect instructions increment/decrement the register being used before/after use as appropriate.  For a full description of the instructions take a look at the [Byte Magazine Volume 02 Number 11 - November 1977](https://archive.org/details/byte-magazine-1977-11-rescan/page/n155/mode/2up) article.


## Porting Sweet 16 to the Commodore VIC-20

The original Sweet 16 source code has been published a number of times including in [Byte Magazine Volume 02 Number 11 - November 1977](https://archive.org/details/byte-magazine-1977-11-rescan/page/n151/mode/2up).  In this article Steve Wozniak encourages users to modify Sweet 16 and even to port it to other processors, so hopefully he won't mind its being ported to the Vic.  However, despite this and the fact that the code is widely available, it is still probably under copyright and therefore the port relies on patching the original source code rather than supplying a complete version.

I can't claim too much credit for porting it as beyond deciding on a suitable location for the registers in the zero page and aligning the code so that part of it fits into a single page, the majority of the work was converting the code to assemble using the [XA](https://www.floodgap.com/retrotech/xa/) assembler.  Sweet16 needs 32 bytes in zero page for the registers, so I chose locations _$2B-$4A_.  This will stop Basic programs from working, unless you save and restore those locations when needed, but does allow the Basic `SYS` command to still execute machine code.

I have uploaded the patch and test program to github: [sweet16_vic20](https://github.com/lawrencewoodman/sweet16_vic20).  Full instructions for patching, assembling and running the code are provided in the [README](https://github.com/lawrencewoodman/sweet16_vic20/blob/master/README.md).

## Example Code

Below are a few examples to show what Sweet 16 looks like in use.

### Memory Region Copy

Copying a string to a new location with Sweet 16.

``` asm6502
DST         = $02BC                   ; Destination for memory copy
LEN         = $0005                   ; Length of memory to copy


copyHello   jsr  SW16                 ; Execute following Sweet 16 code
            .byt $11, <hello, >hello  ; SET  R1   Source Address
            .byt $12, <DST, >DST      ; SET  R2   Destination Address
            .byt $13, <LEN, >LEN      ; SET  R3   Length
            .byt $41                  ; LD   @R1
            .byt $52                  ; ST   @R2
            .byt $F3                  ; DCR  R3
            .byt $07, $FB             ; BNZ  -4
            .byt $00                  ; RTN
            rts

hello       .asc "HELLO"              ; String to copy
```

### 16-bit Multiplication

Using Sweet 16 to calculate 255*100.

``` asm6502
X           = 255                     ; The values to multiply
Y           = 100

mulNums     jsr  SW16                 ; Execute following Sweet 16 code
            .byt $10 : .word 0000     ; SET  R0   sum
            .byt $11 : .word X        ; SET  R1   x
            .byt $12 : .word Y        ; SET  R2   y
            .byt $13 : .word result   ; SET  R3   result
            .byt $F2                  ; DCR  R2
            .byt $05, $03             ; BM 3
            .byt $A1                  ; ADD  R1
            .byt $01, $FA             ; BR   -5
            .byt $73                  ; STD  @R3
            .byt $00                  ; RTN
            rts

result      .word $0000               ; The result of the multiplication
```


### Two's Complement
Getting the two's complement of a number by using Sweet 16 to load the value, then returning to 6502 code to call a routine to one's complement the value, then finally going back to Sweet 16 to add one to the value.

``` asm6502
A           = $0010                   ; The value to two's complement

negate      jsr  SW16                 ; Execute following Sweet 16 code
            .byt $11 : .word A        ; SET  R1   a
            .byt $13 : .word result   ; SET  R3   result
            .byt $21                  ; LD   R1
            .byt $73                  ; STD  @R3
            .byt $00                  ; RTN
            jsr  notRes               ; One's complement RESULT
            jsr  SW16                 ; Continue executing Sweet 16 code
            .byt $C3                  ; POPD @R3
            .byt $E0                  ; INR  R0
            .byt $73                  ; STD  @R3
            .byt $00                  ; RTN


            ; One's complement RESULT
notRes      lda  result
            eor  #$FF
            sta  result
            lda  result+1
            eor  #$FF
            sta  result+1
            rts

result      .word $0000               ; The result of the operation
```

## Video Demonstrating Sweet 16

You can see _Sweet 16_ running on the Vic in the following video:

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/NkbY-1BL5Qo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
