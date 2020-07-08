I have created a SUBLEQ Virtual Machine for the Commodore VIC-20.  SUBLEQ is a computer architecture that has only one instruction: SUBLEQ.  The instruction stands for _SUbtract and Branch if Less than or EQual to zero_.  Code for the VM can be found in the [subleq_vic20 repo](https://github.com/lawrencewoodman/subleq_vic20) on GitHub.


## SUBLEQ (SUbtract and Branch if Less than or EQual to zero)

The SUBLEQ instruction stands for _SUbtract and Branch if Less than or EQual to zero_.  Because there is only one instruction, only the operands are specified, which consist of 3 memory addresses that are acted on as follows:

```` text
SUBLEQ a, b, c
Mem[b] := Mem[b] - Mem[a]
if (Mem[b] ≤ 0) goto c
````

To find out more about SUBLEQ have a look at my previous article: [SUBLEQ - A One Instruction Set Computer (OISC)](https://techtinkering.com/articles/subleq-a-one-instruction-set-computer/) and its accompanying [video](https://www.youtube.com/watch?v=o0e7_U7ZmBM "SUBLEQ - A One Instruction Set Computer (OISC)").


## Example: echo

The following executes a simple SUBLEQ program that loops continuously, accepting a key as input and then displaying it on the screen.  It is taken from an example in the [subleq_vic20 repo](https://github.com/lawrencewoodman/subleq_vic20).

``` asm6502
            jmp main

; Point the SUBLEQ VM's memory to the SUBLEQ program code
SL_MEM      = prog

; Include the SUBLEQ virtual machine
#include "subleq.a65"

main        ; SL_run starts the VM executing at SL_MEM
            jsr SL_run
            rts

; The SUBLEQ program code
prog        .word -1, -1, 3
            .word 6, 6, 0
            .word 0
```

<br />

This SUBLEQ program would look like the following in my [sblasm](https://github.com/lawrencewoodman/sblasm) assembly language, which uses `sble` to indicate a SUBLEQ instruction.

``` nasm
.equ        IN  -1
.equ        OUT -1

loop:       sble  IN, OUT
            sble  z, z, loop
z:          .word 0
```

The assembler assumes that if the last argument of the `sble` instruction isn't supplied then it will be equal to the next location in memory.  It doesn't actually store an opcode for the `sble` instruction as there is only one instruction so only the operands are needed.


## Creating a New SUBLEQ Program Loader

This SUBLEQ VM for the Vic uses 16-bit words and to load a new SUBLEQ program into it you can follow these steps.

1. Create a file containing you're SUBLEQ program as a series of numbers.  To do this you can use my [sblasm](https://github.com/lawrencewoodman/sblasm) assembler.  Which also contains a number of examples to try and contains a file to link to 'arch.inc.asq' to provide correct values for the VIC-20.
2. Use the _sqtoword.tcl_ script to convert the output from _sblasm_ to `.word` entries, using someting like the following for a _fizzbuzz_ program:
   ``` text
   $ tclsh sqtoword.tcl -n 12 fizzbuzz.sq > fizzbuzz.words
   ```
   The `-n 12` indents the lines by 12 spaces to improve text alignment.
3. There are included skeleton files for unexpanded and 8k+ systems.  Append the output of _sqtoword.tcl_ to one of them:
   ``` text
   $ cat skeleton_8k.a65 fizzbuzz.words > fizzbuzz.a65
   ```
4. Assemble the file using [XA](https://www.floodgap.com/retrotech/xa/), making sure that the path to 'subleq.a65' is in the include path:
   ``` text
   $ xa -o fizzbuzz.prg fizzbuzz.a65
   ```
5. Load the program on your VIC-20 with 8K+ ram expansion and type `RUN` to start it.


## Video Demonstrating the SUBLEQ VM on the VIC-20

You can see the SUBLEQ VM being used on a Commodore VIC-20 in the following video.  It shows the process of assembling a 'rock, paper, scissors' game written in SUBLEQ using _sblasm_, creating a _.a65_ file, assembling that with XA and then running it on a VIC.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/YwjlblkTNqs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
