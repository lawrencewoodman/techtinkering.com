[SUBLEQ](/articles/subleq-a-one-instruction-set-computer/ "TechTinkering Article: SUBLEQ - A One Instruction Set Computer (OISC)") is an interesting architecture because of its simplicity, adaptability and power.  It is therefore an attractive choice for a simple _virtual machine_.  However, this comes at a cost which we will show may mean other options would be a better choice.



## SUBLEQ
This is the classic definition of SUBLEQ (SUbtract and Branch if Less than or EQual to zero) using three operands.

````
SUBLEQ a, b, c
Mem[b] := Mem[b] - Mem[a]
if (Mem[b] ≤ 0) goto c
````

As we can see it is very easy to describe and therefore it makes it very easy to create a virtual machine for it.  Below is a simple version to demonstrate:

```
#define OUT 65535           // Output to STDOUT
#define HALT -1             // Stop processing and exit

void
subleq(int *mem)
{
  int ip = 0;
  int a, b, c;

  while (ip >= 0) {
    a = mem[ip];
    b = mem[ip+1];
    c = mem[ip+2];
    ip += 3;
    if (b == OUT) {
      printf("%c", (char)mem[a]);
    } else {
      mem[b] -= mem[a];
      if (mem[b] <= 0) ip = c;
    }
  }
}
```

## Four Instruction Alternative

To demonstrate why SUBLEQ may not be the best choice for a virtual machine, the following describes a four instruction alternative.  This isn't mean to be an ideal VM it is simply being used because like SUBLEQ each instruction is described by three words, in this case as `instruction operandA, operandB`.  The first two instructions are simply to replace the functionality of SUBLEQ and then there are two more that will significantly enhance the instruction set.

```
SUB  a, b
Mem[b] := Mem[b] - Mem[a]

JLE  a, b
if (Mem[a] ≤ 0) goto b

MOV  a, b
Mem[b] := Mem[a]

JE   a, b
if (Mem[a] = 0) goto b
```

As easy as a SUBLEQ VM is to implement, a simple virtual machine using just four instructions is almost as easy and yet provides considerable advantages in terms of code size and speed.

```
#define OUT 65535           // Output to STDOUT
#define HALT -1             // Stop processing and exit

// Instructions
#define SUB 0
#define JLE 1
#define MOV 2
#define JE  3

void
fourInst(int *mem)
{
  int ip = 0;
  int op, a, b;

  while (ip >= 0) {
    op = mem[ip];
    a = mem[ip+1];
    b = mem[ip+2];
    ip += 3;

    switch (op) {
      case SUB:
        mem[b] -= mem[a];
        break;
      case JLE:
        if (mem[a] <= 0) ip = b;
        break;
      case MOV:
        if (b == OUT) {
          printf("%c", (char)mem[a]);
        } else {
          mem[b] = mem[a];
        }
        break;
      case JE:
        if (mem[a] == 0) ip = b;
        break;
    }
  }
}
```

## Code Size

Below are some common macros that we'll use to compare the code size of the two instruction sets.  On the left are the macros written using SUBLEQ and on the right are the same macros written using the four instruction alternative.  Against each label is the number of words used to define the macro.  For the SUBLEQ macros, `sble` is used to differentiate between a three operand SUBLEQ instruction and a macro.


````
; Add mem[a] to mem[b]
; SUBLEQ: 9 words             Four Instruction: 9 words
.macro Add a b                .macro Add a, b
  sble  a Z                     SUB  a, Z
  sble  Z b                     SUB  Z, b
  sble  Z Z                     SUB  Z, Z
.endm                         .endm


; Copy mem[a] to mem[b]
; SUBLEQ: 12 words            Four Instruction: 3 words
.macro Mov a b                .macro Mov a, b
  sble  b b                     MOV  a, b
  Add   a b                   .endm
.endm


; Jump directly to c
; SUBLEQ: 3 words             Four Instruction: 3 words
.macro Jmp c                  .macro Jmp c
  sble  Z Z c                   JLE  Z, c
.endm                         .endm


; Jump to c if mem[b] ≥ 0
; SUBLEQ: 12 words            Four Instruction: 9 words
.macro Jge b c                .macro Jge b, c
  sble  b Z gte                 JE   b, c
  Jmp   done                    JLE  b, lt
gte:                            Jmp  c
  sble  Z Z c                 lt:
done:                         .endm
  sble  Z Z
.endm


; Jump to c if mem[b] = 0
; SUBLEQ: 15 words            Four Instruction: 3 words
.macro Je b c                 .macro Je b, c
  sble  Z b lte                 JE   b, c
  Jmp   done                  .endm
lte:
  sble  b Z gte
  sble  Z Z done
gte:
  sble  Z Z c
done:
.endm


; Jump to c if mem[b] != 0
; SUBLEQ: 15 words            Four Instructions: 6 words
.macro Jne b c                .macro Jne b, c
  sble  Z b lte                 JE   b, eq
  sble  Z Z c                   Jmp  c
lte:                          eq:
  sble  b Z gte               .endm
  sble  Z Z c
gte:
  sble  Z Z
.endm


; Copy mem[mem[a]] to mem[mem[b]]
; SUBLEQ: 60 words            Four Instruction: 9 words
.macro copy_pp a b            .macro copy_pp a, b
  Mov   b cpyWord               MOV  a, cpyWord+1
  Mov   b cpyWord+1             MOV  b, cpyWord+2
  Mov   a cpyWord+3           cpyWord:
  Mov   b cpyWord+7             MOV  0, 0
                              .endm
cpyWord:
  sble  0 0
  sble  0 Z
  sble  Z 0
  sble  Z Z
.endm
````

The following table compares the number of words used by each macro for each instruction set.

<table class="neatTable">
  <tr>
    <th>Macro</th>
    <th>SUBLEQ</th>
    <th>Four Instructions</th>
  </tr>
  <tr><td>Add</td><td class="centre">&nbsp;9</td><td class="centre">9</td></th>
  <tr><td>Mov</td><td class="centre">12</td><td class="centre">3</td></th>
  <tr><td>Jge</td><td class="centre">12</td><td class="centre">9</td></th>
  <tr><td>Je</td><td class="centre">15</td><td class="centre">3</td></th>
  <tr><td>Jne</td><td class="centre">15</td><td class="centre">6</td></th>
  <tr><td>copy_pp</td><td class="centre">60</td><td class="centre">9</td></th>
</table>

It's quite clear that using just four instructions can significantly reduce code size.  The table also shows where further instructions would lead to even smaller code.



## Execution Time

To give an idea of the difference in speed of the VMs we will use two programs.  Each has the program written in SUBLEQ on the left with the same program on the right written using the four instruction alternative.  The SUBLEQ programs don't indicate `sble` as they are not using macros.

The first program, `longLoop`, is just one long loop.  This is useful because the four instruction version only uses `JLE` and `SUB` instructions which are nearly functionally equivalent to the SUBLEQ instruction.  It is also useful because it shows a deficiency in splitting SUBLEQ into two instructions because it can't decrement `count` and exit the loop if it equals `0` using a single instruction.


```
// longLoop
        ; SUBLEQ: 16 words    ; Four Instructions: 15 words
        MONE count            loop:   JLE  count, done
loop:   ONE count done                SUB  ONE, count
        Z Z loop                      JLE  Z, loop
done:   Z Z HALT              done:   JLE  Z, HALT
count:  900000000             count:  .word  900000000
Z:      00                    Z:      .word  00
ONE:    01                    ONE:    .word  01
MONE:   -1
```

The send program, `longCopyLoop`, repeatedly copies one location to another in a long loop.  This makes use of the `MOV` instruction to reduce code size and increase speed.  In this routine, `JE` is functionally equivalent to `JLE` and therefore is only here to make the routine clearer.

```
// longCopyLoop
        ; SUBLEQ: 27 words    ; Four Instructions: 20 words
        MONE count            loop:   JE   count, done
loop:   ONE count done        copy:   MOV  tmpA, tmpB
copy:   tmpB tmpB                     SUB  ONE, count
        tmpA Z                        JE   Z, loop
        Z tmpB                done:   JE   Z, HALT
        Z Z loop              count:  .word  900000000
done:   Z Z HALT              Z:      .word  00
count:  900000000             ONE:    .word  01
Z:      00                    tmpA:   .word  02
ONE:    01                    tmpB:   .word  02
MONE:   -1
tmpA:   02
tmpB:   02
```


The table below compares the execution time and size of our two programs when run on the VMs described above.


<table class="neatTable">
  <tr>
    <th>Program</th>
    <th colspan=2>SUBLEQ</th>
    <th colspan=2>Four Instructions</th>
  </tr>
  <tr>
    <th></th>
    <th>Time (secs)</th>
    <th>Size (words)</th>
    <th>Time (secs)</th>
    <th>Size (words)</th>
  </tr>

  <tr><td>longLoop</td><td class="centre">23.01</td><td class="centre">16</td><td class="centre">21.86</td><td class="centre">15</td></th>
  <tr><td>longCopyLoop</td><td class="centre">56.99</td><td class="centre">27</td><td class="centre">27.16</td><td class="centre">20</td></th>
</table>

We can see from these two programs that simple programs are comparable with a slight advantage to the four instruction set.  However, as the complexity of the programs increase it becomes clear that the four instruction set VM gives a significant advantage in terms of code size and execution time.  That said any attempt at benchmarking will be flawed and routines could be developed that would show the opposite.  However, these routines do demonstrate a useful advantage of the four instruction alternative.


## Conclusion

By replacing the SUBLEQ VM with a VM using just four instructions we have shown that it provides a considerable improvement at the cost of only a small increase in complexity of the VM.  This is despite our four instructions only needing 2-bits of the word used to hold the instruction and therefore 'wasting' the remaining bits.

It would be easy to expand the number of instructions and add extra addressing modes which would provide further advantages.  However, this does lead to one downside of this approach because we could spend an almost infinite amount of time tinkering with the right combinations of instructions, addressing modes and other changes.  Whereas the conceptual simplicity and constrained nature of SUBLEQ means there isn't as much to tinker with and therefore once the choice has been made to use it people can get on with other things which may interest them more; witness what has been possible with DawnOS.

The initial simplicity of SUBLEQ pushes the complexity outwards as it has to go somewhere.  It's a balancing act and we therefore need to make a decision as to where we want to place that complexity so that we can get the right combination of easy of use, code size, speed, efficiency, etc.

I like SUBLEQ and while it may not be the perfect choice for a VM it is still an interesting option that can be fun to play with.
