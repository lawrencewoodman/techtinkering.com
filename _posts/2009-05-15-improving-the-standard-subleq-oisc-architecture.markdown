---
layout: article
title: "Improving the Standard SUBLEQ OISC (One Instruction Set Computer) Architecture"
summaryPic: small_subleq_plus.jpg
tags:
  - Computer Architecure
  - SUBLEQ
  - OISC
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

When I first came across [The SUBLEQ URISC (Ultimate RISC) / OISC (One Instruction Set Computer) Architecture](/2009/03/05/the-subleq-urisc-oisc-architecture/),
I really liked the beauty and simplicity of the design.  However, I have now been experimenting with it for quite a while and have noticed one aspect of the standard implementation that I am not so happy with.  In the standard implementation, negative numbers are used for Input/Output Ports or to Halt the machine in the case of a branch destination.  This seems such as waste of the
negative numbers, as generally only a couple will be used meaning that nearly half of the addressing capacity is lost for little gain.  I propose the following improvement to the standard SUBLEQ design.

<h2>Design Improvement Options</h2>
While working out how to stop the waste of negative numbers, I considered the following factors: beauty, ease of implementation/simplicity, instructions executed, number of memory accesses and code size. A number of options were looked at, including negative numbers representing: <em>literals</em>, <em>relative addressing</em> and <em>in-direct addressing</em>.

<h2>Improved Design</h2>
The improved design is similar to the standard design as described in my article: <a href="/2009/03/05/the-subleq-urisc-oisc-architecture/">The SUBLEQ URISC (Ultimate RISC) / OISC (One Instruction Set Computer) Architecture</a>.  The key difference is that negative numbers now refer to <em>in-direct addressing</em>.

The improved design is described as follows:

**SUBLEQ** - Subtract and Branch if Less then or Equal to zero


In cases where a, b and c are ≥ 0 the following holds true:

    SUBLEQ a, b, c
    Mem[b] := Mem[b] - Mem[a]
    if (Mem[b] ≤ 0) goto c

Where a or b or c < 0 then _in-direct addressing_ takes effect in the following way:

    If a < 0 then Mem[a] above becomes Mem[Mem[|a|]]
    If b < 0 then Mem[b] above becomes Mem[Mem[|b|]]
    If c < 0 then goto c above becomes goto Mem[|c|]

To refer to ports I suggest that certain memory locations be mapped to the ports.  For example `Mem[0]` could be mapped to the Standard Input Port and `Mem[1]` could be mapped to the Standard Output Port.  Then the code would start at the next address say, `Mem[2]`.

<h2>Comparison of the Two Implementations</h2>
To compare the standard implementation with the improved implementation of SUBLEQ, I have chosen three tests that I am particularly interested in:
<ul>
<li><strong>Call and Return</strong>
<dl>
<dt>Call</dt><dd>Calls a function by first pushing the return address onto a return stack and then jumping to the address of the function.</dd>
<dt>Return</dt><dd>Returns from a function by popping the return address from the return stack and jumping to it.</dd>
</dl>
</li>
<li><strong>Push and Pop</strong>
<dl>
<dt>Push</dt><dd>Pushes a word onto a data stack.</dd>
<dt>Pop</dt><dd>Pops a word off of a data stack.</dd>
</dl>
</li>
<li><strong>Block Memory Move</strong>
<dl>
<dt>BlockMove</dt><dd>Moves a block of memory from one address to another.</dd>
</dl>
</li>
</ul>


The code for the three tests can be found in the Appendix at the bottom of this article.

To work out the number of Memory Accesses for each Instruction Executed, I took 5 Memory Accesses as the standard number when using direct addressing: 3 to read in the instruction plus 2 to read in the locations that the <em>a</em> and <em>b</em> fields refer to.  I then added 1 Memory Access for each <em>in-direct</em> field used.

Below are tables comparing the performance of the two designs:

<h3>Call and Return</h3>
<table class="neatTable">
<tr><th>Case</th><th>Instructions Executed</th><th>Memory Accesses</th><th>Code Size in Words</th></tr>
<tr><td>Original SUBLEQ</td><td>18</td><td>90</td><td>55</td></tr>
<tr><td>Improved SUBLEQ</td><td>7</td><td>39</td><td>22</td></tr>
</table>

<h3>Push and Pop</h3>
<table class="neatTable">
<tr><th>Case</th><th>Instructions Executed</th><th>Memory Accesses</th><th>Code Size in Words</th></tr>
<tr><td>Original SUBLEQ</td><td>20</td><td>100</td><td>60</td></tr>
<tr><td>Improved SUBLEQ</td><td>10</td><td>54</td><td>30</td></tr>
</table>

<h3>Block Memory Move (50 Words Moved)</h3>
<table class="neatTable">
<tr><th>Case</th><th>Instructions Executed</th><th>Memory Accesses</th><th>Code Size in Words</th></tr>
<tr><td>Original SUBLEQ</td><td>468</td><td>2340</td><td>82</td></tr>
<tr><td>Improved SUBLEQ</td><td>364</td><td>1974</td><td>66</td></tr>
</table>

<h2>Summary</h2>
It can be seen from the comparisons above that the improved design reduces the number of instructions executed, memory accesses and code size.  I believe that it would not add much to the complexity of implementation and that it enhances the beauty of the design.  My only remaining dissatisfaction with the design is that the branch address is rarely used, therefore wasting one word and one memory access per instruction.  I intend to tackle this remaining problem in a future article.
 

<hr />
<h2>Appendix</h2>

<h3>Implementation Test Examples</h3>
The test examples given below are implemented as macros to ensure some uniformity in testing.  I appreciate that if macros were not used that there are quicker ways of implementing some of these tests, particularly the block memory move.  However, I wanted a way to compare general programming techniques.

The following conventions hold true to the code examples given below:

<table class="neatTable">
<tr><td>*</td><td>Before a field means that the address is in-direct, otherwise it is direct</td></tr>
<tr><td>.</td><td>At the start of a line means that it is not an instruction</td></tr>
<tr><td>?</td><td>Indicates the current address</td></tr>
<tr><td>Z</td><td>This is a memory address normally containing 0</td></tr>
<tr><td>ONE</td><td>This is a memory address normally containing 1</td></tr>
<tr><td>MO</td><td>This is a memory address normally containing -1</td></tr>
<tr><td>:</td><td>Indicates that the text before it is a label.  Labels within macros are local to that macro.</td></tr>
</table>


<h4>Original SUBLEQ Code</h4>
Below are the implementations of the Macros in the standard form of SUBLEQ.

{% highlight text %}
;---------------------------------------------------------------------------
; Calls a subroutine by first pushing the return address
; onto the return stack and then jumping to the subroutine's address.
; Assumes mem[Z] = 0, mem[MO] = -1 
; and mem[returnStackPtr] points to memory to use as the return stack.
; Leaves mem[Z] = 0
;---------------------------------------------------------------------------
Macro Call address			

           ; Zero Top Of Return Stack and Copy Return Stack Pointer
           zeroTORS zeroTORS
           zeroTORS+1 zeroTORS+1
           add+1 add+1
           returnStackPtr Z
           Z zeroTORS
           Z zeroTORS+1
           Z add+1
zeroTORS:  Z Z

           ; Copy Return Address to Return Stack
           Z Z
           returnAddress Z
add:       Z Z

           MO returnStackPtr     ; Increment Stack pointer
           Z Z address           ; Jump to the address

. returnAddress:   ?+1           ; Label to indicate return address
EndMacro
{% endhighlight %}

`Call`: Instructions executed: 13  Memory Accesses: 65  Code Size: 40

{% highlight text %}
;---------------------------------------------------------------------------
; Returns from a subroutine call by popping the return address and then
; jumping to it.
; Assumes mem[Z] = 0, mem[ONE] = 1 
; and mem[returnStackPtr] points to memory to use as the return stack.
; Leaves mem[Z] = 0
;---------------------------------------------------------------------------
Macro Ret

           ; Decrement Stack pointer
           ONE returnStackPtr    
           
           ; Copy Return Stack Pointer
           jump+2 jump+2
           returnStackPtr Z
           Z jump+2
           
           ; Jump to return address
jump:      Z Z Z			
EndMacro
{% endhighlight %}

`Ret`: Instructions executed: 5  Memory Accesses: 25  Code Size: 15

`Call` and `Ret` Total: Instructions executed: 18  Memory Accesses: 90  Code Size: 55	

{% highlight text %}
;---------------------------------------------------------------------------
; Pushes word at address onto Data Stack.
; Assumes mem[Z] = 0
; and mem[stackPtr] points to memory to use as the data stack.
; Leaves mem[Z] = 0
;---------------------------------------------------------------------------
Macro Push address			

           ; Zero Top of Data Stack
           zeroTODS zeroTODS
           zeroTODS+1 zeroTODS+1
           add+1 add+1
           stackPtr Z
           Z zeroTODS
           Z zeroTODS+1
           Z add+1
zeroTODS:  Z Z
           Z Z							

           ; Copy data at address to Top of Data Stack
           address Z
add:       Z Z
	
           ; Increments Stack Pointer
           MO stackPtr	
           Z Z							
End Macro
{% endhighlight %}
`Push`: Instructions executed: 13  Memory Accesses: 65  Code Size: 39	
	
{% highlight text %}
;---------------------------------------------------------------------------
; Pops word off Data Stack into  address.
; Assumes mem[Z] = 0, mem[ONE] = 1
; and mem[stackPtr] points to memory to use as the data stack.
; Leaves mem[Z] = 0
;---------------------------------------------------------------------------
Macro Pop address
           ; Decrement Stack Pointer
           ONE stackPtr								

           ; Zero destination address
           address address						
	
           ; Pop the data off the stack	
           add add					
           stackPtr Z
           Z add
add:       Z address
           Z Z
End Macro
{% endhighlight %}
`Pop`: Instructions executed: 7  Memory Accesses: 35  Code Size: 21	

`Push` and `Pop` Total: Instructions executed: 20  Memory Accesses: 100  Code Size: 60


{% highlight text %}
;---------------------------------------------------------
; Moves numWords of memory from srcAddress to dstAddress.
; Assumes mem[Z] = 0, mem[MO] = -1 and mem[ONE] = 1
; Leaves mem[Z] = 0 
; Doesn't alter mem[MO] or mem[ONE]
;---------------------------------------------------------
Macro BlockMove srcAddress dstAddress numWords	

           ; Copy macro parameters to working storage
           getSrc getSrc
           srcCopy Z
           Z getSrc
           Z Z

           zeroDst zeroDst
           zeroDst+1 zeroDst+1
           add+1 add+1
           dstCopy Z
           Z zeroDst
           Z zeroDst+1
           Z add+1         
           Z Z
	
           counter counter
           wordsCopy Z
           Z counter
           Z Z
           MO counter                     ; Increment num of words for loop below

loop:      ONE counter moveFinished       ; Decrement num of words working copy and loop until all copied	

           ; Move source to destination
zeroDst:   dstAddress dstAddress
getSrc:    srcAddress Z
add:       Z dstAddress

           ; Increment source and destination pointers
           MO zeroDst
           MO zeroDst+1
           MO getSrc
           MO add

           Z Z loop

; Working copies of the macro parameters
. counter:   0

; Copies of the macro parameters so as not to alter their values if used again
. srcCopy:  srcAddress
. dstCopy:  dstAddress
. wordsCopy:  numWords
movedFinished:
EndMacro
{% endhighlight %}



`BlockMove`: Instructions executed: 468  Memory Accesses: 2340 Code Size: 82


<h4>Improved SUBLEQ Code</h4>
Below are the implementations of the Macros in the improved form of SUBLEQ that uses negative numbers for in-direct addressing.

{% highlight text %}
;---------------------------------------------------------------------------
; Calls a subroutine by first pushing the return address
; onto the return stack and then jumping to the subroutine's address.
; Assumes mem[Z] = 0, mem[MO] = -1 
; and mem[returnStackPtr] points to memory to use as the return stack.
; Leaves mem[Z] = 0
;---------------------------------------------------------------------------
Macro Call address

           ; Copy return address to stack
           *returnStackPtr *returnStackPtr    ; Zero stack entry	
           returnAddress Z
           Z *returnStackPtr		

           MO returnStackPtr                  ; Increment Stack pointer
           Z Z address                        ; Jump to the address

returnAddress:    ?+1                         ; Label to indicate return address
returnLabel:
End Macro
{% endhighlight %}
`Call`: Instructions executed: 5  Memory Accesses: 28  Code Size: 16

{% highlight text %}
;---------------------------------------------------------------------------
; Returns from a subroutine call by popping the return address and then
; jumping to it.
; Assumes mem[Z] = 0, mem[ONE] = 1 
; and mem[returnStackPtr] points to memory to use as the return stack.
; Leaves mem[Z] = 0
;---------------------------------------------------------------------------
Macro Ret
           One returnStackPtr          ; Decrement Stack pointer
           Z Z *returnStackPtr         ; Jump to return address
End Macro
{% endhighlight %}
`Ret`: Instructions executed: 2  Memory Accesses: 11  Code Size: 6	

{% highlight text %}
;---------------------------------------------------------------------------
; Pushes word at address onto Data Stack.
; Assumes mem[Z] = 0
; and mem[stackPtr] points to memory to use as the data stack.
; Leaves mem[Z] = 0
;---------------------------------------------------------------------------
Macro Push address			

           *stackPtr *stackPtr        ; Zero stack entry
	
           ; Copy data at address to Stack
           address Z
           Z *stackPtr

           MO stackPtr                ; Increments Stack Pointer
           Z Z
End Macro
{% endhighlight %}
`Push`: Instructions executed: 5  Memory Accesses: 28  Code Size: 15	

{% highlight text %}
;---------------------------------------------------------------------------
; Pops word off Data Stack into  address.
; Assumes mem[Z] = 0, mem[ONE] = 1
; and mem[stackPtr] points to memory to use as the data stack.
; Leaves mem[Z] = 0
;---------------------------------------------------------------------------
Macro Pop address			
           One stackPtr          ; Decrement Stack Pointer
           address address       ; Zero destination address
	
           ; Pop the data off the stack	
           *stackPtr Z
           Z address             ; Pop data from stack into address
           Z Z
End Macro
{% endhighlight %}
`Pop`: Instructions executed: 5  Memory Accesses: 26  Code Size: 15	

`Push` and `Pop` Total: Instructions executed: 10  Memory Accesses: 54  Code Size: 30	

{% highlight text %}
;---------------------------------------------------------
; Moves numWords of memory from srcAddress to dstAddress.
; Assumes mem[Z] = 0, mem[MO] = -1 and mem[ONE] = 1
; Leaves mem[Z] = 0 
; Doesn't alter mem[MO] or mem[ONE]
;---------------------------------------------------------
Macro BlockMove srcAddress dstAddress numWords

           ; Copy macro parameters to working storage
           srcWrk srcWrk
           srcCopy Z
           Z srcWrk
           Z Z

           dstWrk dstWrk
           dstWrk Z
           Z dstWrk
           Z Z

           numWrk numWrk
           numWrk Z
           Z numWrk
           Z Z
           MO numWrk                   ; Increment num of words for loop below

loop:      ONE numWrk moveFinished     ; Decrement num of words working copy and loop until all copied	

           ; Zero destination
           *dstWrk *dstWrk

           ; Add source to destination
           *srkWrk Z
           Z *dstWrk
	
           ; Increment srcWrk and dstWrk
           MO srcWrk
           MO dstWrk

           Z Z loop

; Working copies of the macro parameters
. srcWrk:   0
. dstWrk:   0
. numWrk:   0

; Copies of the macro parameters so as not to alter their values if used again
. srcCopy:  srcAddress
. dstCopy:  dstAddress
. wordsCopy:  numWords
movedFinished:
EndMacro
{% endhighlight %}

`BlockMove`: Instructions executed: 364  Memory Accesses: 1974 Code Size: 66


