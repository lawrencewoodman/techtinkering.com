SUBLEQ has to be one of the easiest architectures to implement in either software or hardware and this is the main reason for its design as a teaching aid.  It has only one instruction, hence why it is called a One Instruction Set Computer (OISC), which isn't the best name considering that most processors have one instruction set.  URISC is good, but perhaps One Instruction Computer (OIC) would be more accurate.

### SUBLEQ (SUbtract and Branch if Less than or EQual to zero)

The SUBLEQ instruction stands for _SUbtract and Branch if Less than or EQual to zero_.  Because there is only one instruction, only the operands are specified, which consist of 3 memory addresses that are acted on as follows:

```` text
SUBLEQ a, b, c
Mem[b] := Mem[b] - Mem[a]
if (Mem[b] ≤ 0) goto c
````

## Programming Using Macros
To program in SUBLEQ we can create a set of macros to ease development.  Below are some simple examples of useful macros that could be implemented.  The contents of each macro consists of previously defined macros or the `sble` instructin which is short for SUBLEQ.

The examples below are written using my [sblasm](https://github.com/lawrencewoodman/sblasm) macro assembler.  Where the third operand is missing for `sble`, it is assumed to be the location of the next instruction, i.e. it doesn't conditionally branch.  Mem\[z\] is assumed to contain zero.  Numbers beginning with `#` are literals which are memory locations containing that number.

``` nasm
; Add a to b
.macro      add   a b
            sble  a z
            sble  z b
            sble  z z
.endm


; Increment value at n
.macro      inc   n
            sble  #-1 n
.endm


; Decrement value at n
.macro      dec   n
            sble  #1 n
.endm


; Jump to addr
.macro      jump  addr
            sble  z z addr
.endm


; Copy value at src to dest
.macro      copy  src dest
            sble  dest dest
            add   src dest
.endm


; Jump to 'addr' if 'a' >= 0
.macro      jge   a addr
            sble  a z gte
            jump  done
gte:        sble  z z addr
done:       sble  z z
.endm
```

It can been seen that by building up macros and using certain memory locations in a standard way, that it is relatively easy to program this type of machine.

## Hello World
This program is fairly simple and essentially manipulates two pointers, one to contain the address of the character to be output and the other to contain the address which is checked for zero termination of the string.  We can see that the pointers are actually operands of `sble` instructions, so therefore we are self-modifying code to create a pointer.  This is typical of programming in SUBLEQ.  I have written
this without any macros as it makes it easier to see how SUBLEQ is used.

```
; Outputs "HELLO, WORLD!\n"
;
; Copyright (C) 2020 Lawrence Woodman <lwoodman@vlifesystems.com>
; Licensed under a BSD 0-Clause licence.  See 0BSD_LICENCE.md for details.

.equ        OUT  -1                     ; The display output port
.equ        HALT -1                     ; A location which halts execution

;========================================
;           Start
;========================================
loop:       sble  hello OUT             ; Outputs char pointed to by hello
            sble  minusOne loop         ; Increments char output ptr to next char
            sble  minusOne checkEnd+1   ; Increments end of string ptr to next char
checkEnd:   sble  z hello HALT          ; Halts program if char at ptr is zero
            sble  z z loop              ; Jumps to loop

;========================================
;           Data Storage
;========================================
minusOne:   .word -1                    ; Used to increment ptr
hello:      .asciiz "HELLO, WORLD!\n"
z:          .word 0
```

In the above code we can see that `OUT` is used as a 'b' operand.  This will move the character to the display rather than subtract.  The program finishes when the line at label `checkEnd:` jumps to `HALT`.

## Parallelization Possibilities
There are, of course, many more memory accesses per operation than most standard processors which will make object code larger and will have a negative speed impact.  The speed of the processor could be increased, however, by running some instructions in parallel.  This could be done by running several instructions at the same time if they are using different operands and aren't branching.

## Video Demonstrating SUBLEQ

SUBLEQ can be seen being used via my 'sblasm' assembler in the following video.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/o0e7_U7ZmBM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>


## Further Information
There are a few other projects that use SUBLEQ which might be of interest.

### Oleg Mazonka
My first experiments with SUBLEQ were using [Oleg Mazonka's](http://mazonka.com/subleq/index.html) assembler and interpreter.  He has done quite a bit with SUBLEQ including creating a simplified typeless C style language which he calls 'Higher Subleq'.

### KimUno

The [KIM Uno](https://www.instructables.com/id/The-KIM-Uno-a-5-Microprocessor-Dev-Kit-Emulator/) is a microprocessor dev kit that uses an Arduino microcontroller to run a SUBLEQ emulator.

### Dawn Operating System

[Dawn](http://gerigeri.uw.hu/DawnOS/index.html) is a multi-tasking operating system created to run on a SUBLEQ, featuring a GUI, touchscreen support, sound, joysticks, cameras, SMP, etc.  It seems to have been written using it's supplied C compiler which compiles down to SUBLEQ and it really is very impressive.  It was written by a Hungarian called Geri.

### sblasm

[sblasm](https://github.com/lawrencewoodman/sblasm) is a macro assembler that I've written for SUBLEQ.  It's a work in progress but has some quite nice features and I'm continuing to develop it.
