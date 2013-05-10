---
layout: article
title: "Hello, World! in SUBLEQ Assembly"
summaryPic: small_hello_subleq.jpg
tags:
  - Programming
  - OISC
  - SUBLEQ
  - Assembly
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

After writing a previous article\: [The SUBLEQ URISC (Ultimate RISC) / OISC (One Instruction Set Computer) Architecture](/2009/03/05/the-subleq-urisc-oisc-architecture/).  I was left thinking that I should really have given at least a "hello, world" program as a demonstration.  I was then inspired after seeing John Metcalf's post: [Hello World for the RSSB Virtual Computer](http://retrocode.blogspot.com/2009/01/hello-world-for-rssb-virtual-computer.html).  This showed that these OISCs don't require as much code as people may think to do what you want.  So here is my version of a "hello, world" program for the SUBLEQ Architecture.  

## Assembly Source Code
The following assembly code is written for Oleg Mazonka's SUBLEQ assembler, which can be found on his [page](http://mazonka.com/subleq/index.html).  I have saved it to a file called `helloworld.sq`

{% highlight text %}
############################################
#  FileName:   helloworld.sq
#  Author:     Lawrence Woodman
#  Date:       26th March 2009
#===========================================
#  Outputs 'hello, world'
############################################
loop:       hello (-1)              # Outputs character pointed to by hello
            minusOne loop           # Increments character output pointer to next character
            minusOne checkEnd+1     # Increments end of string pointer to next character
checkEnd:   Z hello (-1)            # Halts program if character at pointer is zero
            Z Z loop                # Jumps to loop
				
# Data Storage				
. minusOne: -1                      # Used to increment pointer
. hello: "hello, world\n" Z: 0      # Zero terminated string to print
{% endhighlight %}

The program is fairly simple and essentially manipulates two pointers, one to contain the address of the character to be output and the other to contain the address which is checked for zero termination of the string.  You will see that the pointers are actually operands of SUBLEQ instructions, so therefore we are manipulating operands to create a pointer.  This is typical of programming in SUBLEQ assembly.

To recap from my previous article on <a href="/2009/03/05/the-subleq-urisc-oisc-architecture/">SUBLEQ Architecture</a>.  Every line is assumed to be a SUBLEQ instruction, so just the operands are specified.  The SUBLEQ instruction works as follows:

**SUBLEQ** = Subtract and Branch if Less then or Equal to zero

    SUBLEQ a, b, c
    Mem[b] = Mem[b] - Mem[a]
    if (Mem[b] ≤ 0) goto c

There are a couple of points to note in the above assembly source code:
* (-1) is used on the line labeled `loop` to indicate that the result should be output to STDOUT.
* (-1) is used on the line labeled `checkEnd` to halt the program as -1 is an invalid address to jump to.
* (-1) is in parenthesis to indicate another expression, as opposed to `hello-1`, which would be the address prior to `hello`.
* The assembler assumes that the branch destination is the next address for the three lines that only have two operands.
* The period on the last two lines indicates that these lines don't contain instructions and hence are not operands of a SUBLEQ instruction.

I assembled the file using:
{% highlight bash %}
$ sqasm < helloworld.sq > helloworld.out
{% endhighlight %}


## Object Code
Assembling produces the file `helloworld.out`, which contains the following:
{% highlight text %}
16 -1 3 
15 0 6 
15 10 9 
30 16 -1 
30 30 0 
-1 
104 101 108 108 111 44 32 119 111 114 108 100 33 10 0
{% endhighlight %}

## Executing the Program
To run this you just use:
{% highlight bash %}
$ sqrun helloworld.out
{% endhighlight %}

Which produces the correct output:
<pre><samp>hello, world</samp></pre>

## Further Information
To find out more about SUBLEQ architecture have a look at my article mentioned above: <a href="/2009/03/05/the-subleq-urisc-oisc-architecture/">The SUBLEQ URISC (Ultimate RISC) / OISC (One Instruction Set Computer) Architecture</a>.  This offers a fuller explanation and contains a few links of interest.
