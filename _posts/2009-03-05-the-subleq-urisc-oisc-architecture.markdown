---
layout: article
title: "The SUBLEQ URISC (Ultimate RISC) / OISC (One Instruction Set Computer) Architecture"
summaryPic: small_urisc_oisc.jpg
tags:
  - Computer Architecure
  - OISC
  - SUBLEQ
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
I have been interested in the limits of RISC (Reduced Instruction Set Computer) architecture for a while and recently came across OISC (One Instruction Set Computer) \ URISC (Ultimate RISC) architecture when looking for a simple way to implement a Virtual Machine for an A.I. project I was working on.  It has to be one of the easiest architectures to implement in either software or hardware and this is the main reason for its design as a teaching aid.  It has only one instruction, hence the name, which isn't the best name considering that most processors have one instruction set.  URISC is good, but perhaps OIC (One Instruction Computer) would have been more accurate.

There are a number of types of OISCs, but this article will concentrate on those using the SUBLEQ instruction, as this is the one that I favour.  Mention should also be made of those using the SUBNEG instruction which is very similar.  Because there is only one instruction, only the operands are specified, which in this case consists of 3 memory addresses that are acted on as explained below:
### SUBLEQ (Subtract and Branch if Less then or Equal to zero)

    SUBLEQ a, b, c
    Mem[b] := Mem[b] - Mem[a]
    if (Mem[b] ≤ 0) goto c

### SUBNEG (Subtract and Branch if Negative)

    SUBNEG a, b, c
    Mem[b] := Mem[b] - Mem[a]
    if (Mem[b] < 0) goto c

## Implementation Options
There are a number of implementation options for a SUBLEQ processor:

* Negative numbers could refer to Input/Output ports.
* Relative addressing could be used rather than direct addressing.
* If an address is used as an Input/Output port, then this could copy the data rather than run SUBLEQ on it.
* The branch destination could refer to a memory location that contains the actual branch destination, i.e. `goto mem[c]` instead of `goto c`.

## Programming Using Macros
To program the SUBLEQ OISC machine we can create a set of Macros to ease development.  Below are some simple examples of useful macros that could be implemented.  The contents of each Macro consists of previously defined macros or 3 memory location references to be executed by the SUBLEQ instruction.  Where the third operand is missing, it is assumed to be the location of the next instruction, i.e. it doesn't conditionally branch.  Mem\[Z\] is assumed by most of the macros to contain zero.

{% highlight nasm %}
Macro Jmp c     ; Jump directly to c (Resets mem[Z] to zero)
  Z, Z, c       ; mem[Z] := zero and jumps as result is 0
EndMacro

Macro Sub a, b  ; Subtract mem[a] from mem[b]
  a, b          ; Trivial Macro, but can make things clearer
EndMacro

Macro Add a, b  ; Add mem[a] to mem[b] (Assumes mem[Z] = 0)
  Sub a, Z      ; As mem[Z] contains zero, stores negative of mem[a] at mem[Z]
  Sub Z, b      ; Equivalent of: mem[b] := mem[b] - -mem[a] i.e. mem[b] := mem[b] + mem[a]
  Sub Z, Z      ; Set mem[Z] to zero
EndMacro

Macro Mov a, b  ; Copy mem[a] to mem[b] (Assumes mem[Z] = 0)
  Sub b, b      ; Set mem[b] to zero
  Add a,b       ; Add mem[a] to mem[b]
EndMacro

Macro Jge b, c  ; Jump to c if mem[b] ≥ 0
  b, Z, c       ; (Assumes mem[Z] = 0, leaves mem[Z] := -mem[b])
EndMacro

Macro Jle b, c  ; Jump to c if mem[b] ≤ 0 (Assumes mem[Z] = 0)
  Z, b, c
EndMacro

Macro Jz b, c   ; Jump to c if mem[b] = 0 (Assumes mem[Z] = 0)
  Jge b, GE0    ; If b ≥ 0 Jump to GE0
  Jmp NotZero   ; Jump to NotZero and mem[Z] := 0
GE0:
  Sub Z, Z      ; mem[Z] := 0
  Jle b, c      ; If b ≤ 0 Jump to c.  As b is ≥ 0, therefore: If b = 0 jump to c
NotZero:
EndMacro
{% endhighlight %}

It can been seen that by building up macros and using certain memory locations in a standard way, that it is relatively easy to program this type of machine.


## Parallelization Possibilities
There are, of course, many more memory accesses per operation than most standard processors which will make object code larger and will have a negative speed impact.  The speed of the processor could be increased, however, by running some instructions in parallel.  This could be done by running several instructions at the same time if they are using different operands and aren't branching.  

## Further Information
There isn't much about SUBLEQ OISC computers on the internet.  However I have found the following to be useful:
* [A SUBNEG computer built using 7400 series logic chips](http://bitstuff.blogspot.com/2007/02/subtract-and-branch-if-negative.html)
* [Oleg Mazonka's page discussing a self interpreter for a SUBLEQ virtual machine](http://mazonka.com/subleq/index.html).  It also includes an assembler and interpreter.
* [The Wikipedia article on One Instruction Set Computers](http://en.wikipedia.org/wiki/One_instruction_set_computer)

I have also written a follow up article: [Hello, World! in SUBLEQ Assembly](/2009/03/29/hello-world-in-subleq-assembly/).

I hope that you find this interesting and would love to hear of any uses that you find for it.
