---
layout: article
title: "An Introduction to Corewar"
summaryPic: small_corewar.jpg
tags:
  - Programming
  - Corewar
  - Programming Games
  - Retro
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
I remember reading about Corewar roughly 20 years ago and thinking that I will have to have a go at that when I get the time.  As often happens in life, things got in the way and I only recently managed to give it a go.  I love the challenge of programming and the competitive aspect of this programming game really appeals to me.  The object of the game is to write a battle program that will take over a virtual computer and kill the other battle programs running upon it.  Since the game recently celebrated it's 25th birthday, I thought that I would write the following brief introduction to the game to whet peoples' appetite and encourage new interest.
<a name="more"></a>

<h2>History</h2>
The game was first described in <a href="http://corewar.co.uk/cwg.txt">Core War Guidelines</a> by D. G. Jones and A. K. Dewdney in March 1984 and was introduced to the public
in May 1984 via Dewdney's <a href="http://www.corewar.co.uk/vogtmann/first.htm">Computer Recreation</a> column in <em>Scientific American</em>.

There have been several revisions to REDCODE (the form of assembly language in which the programs are written).  The most used is currently The International Core Wars Society (ICWS) 1994 standard with the extensions introduced by pMARS 0.8.  There is also some interest in the older ICWS '88 standard.

<h2>The MARS Environment</h2>
The programs are run in the MARS (Memory Array Redcode Simulator) environment.  The object of the game is for the programs to take over the environment's memory (Core), and kill the other programs.  The core is circular and memory addresses are relative to the current position.  This is so that it does't matter where a program starts in the core.  The biggest difference from a real processor is that each memory location consists of an instruction and its two operands.

As mentioned above, the programs are written in a form of assembly language called REDCODE.  The most common version of this gives the following instructions:


<table class="neatTable">
<tr><td>DAT</td><td>Data</td><td>Kills the current process</td></tr>
<tr><td>MOV</td><td>Move</td><td>Copies data from one address to another</td></tr>
<tr><td>ADD</td><td>Add</td><td>Adds one number to another</td></tr>
<tr><td>SUB</td><td>Subtract</td><td>Subtracts one number from another</td></tr>
<tr><td>MUL</td><td>Multiply</td><td>Multiplies one number by another</td></tr>
<tr><td>DIV</td><td>Divide</td><td>Divides one number by another</td></tr>
<tr><td>MOD</td><td>Modulus</td><td>Divides one number by another and gives the remainder</td></tr>
<tr><td>JMP</td><td>Jump</td><td>Continues execution from another address</td></tr>
<tr><td>JMZ</td><td>Jump if zero</td><td>Tests a number and jumps to an address if it's 0</td></tr>
<tr><td>JMN</td><td>Jump if not zero</td><td>Tests a number and jumps if it isn't 0</td></tr>
<tr><td>DJN</td><td>Decrement and jump if not zero</td><td>Decrements a number by one, and jumps unless the result is 0</td></tr>
<tr><td>SPL</td><td>Split</td><td>Starts a second process at another address</td></tr>
<tr><td>CMP</td><td>Compare</td><td>Same as SEQ</td></tr>
<tr><td>SEQ</td><td>Skip if equal</td><td>Compares two locations, and skips the next instruction if they are equal</td></tr>
<tr><td>SNE</td><td>Skip if not equal</td><td>Compares two locations, and skips the next instruction if they aren't equal</td></tr>
<tr><td>SLT</td><td>Skip if less than</td><td>Compares two locations, and skips the next instruction if the first is less than the second</td></tr>
<tr><td>LDP</td><td>Load from p-space</td><td>Loads a number from private storage space</td></tr>
<tr><td>STP</td><td>Store to p-space</td><td>Stores a number to private storage space</td></tr>
<tr><td>NOP</td><td>No operation</td><td>Does nothing</td></tr>
</table>

In addition, there are a number of different addressing modes and instruction modifiers which change the way that they act.  These combine to make REDCODE able to express a lot in very little code.

<h2>Example Programs</h2>
I have provided slightly altered versions of the standard example programs written by A. K. Dewdney to give you an idea of how the programs work.

<h3>IMP</h3>
This is one of the simplest program that can be written in REDCODE.  It just replicates itself throughout the core and consists of only one instruction:

{% highlight redcode %}
mov.i 0, 1
{% endhighlight %}

This copies memory location 0 to memory location 1.  The `.i` suffix is an instruction modifier which means that `mov` is to copy the whole of the memory location.  Therefore, in this case the instruction copies the current instruction at location 0 (remember that the addressing is relative and a memory location contains an instruction and it's operands) to location 1 (the next location).  Execution then continues at the next memory location, which now contains the same instruction as the last, so this program rapidly replicates itself throughout the core.

However, the program does not kill the other programs, so where it writes over another program, the other program will just execute this code instead.  This is useful to make another program ineffective, but it still needs to be killed by getting it to execute a DAT instruction, otherwise the outcome is likely to be a tie.

<h3>DWARF</h3>
As mentioned above the IMP won't kill another process.  To do this you need to get a process to execute a `DAT` instruction.  This is therefore what the following program does:

{% highlight redcode %}
add.ab  #4, 3        
mov.i   2, @2
jmp    -2
dat    #0, #0
{% endhighlight %}

The program starts by adding the literal number 4 to memory location 3, which contains the `DAT` instruction.  This `DAT` instruction is known as the bomb as it is what will stop another process.  The `.ab` suffix indicates that the A field (containing #4) of the source should be added to the B field (containing #0) of the destination.  The bomb at memory location 2, is then copied to the memory location pointed to by the B field of the bomb.  In-direct addressing via the B field is indicated by the `@` symbol.  Finally the program starts back again at the beginning.  You can therefore see that this copies a bomb to every fourth memory location, and if the core is divisible by four, it will never bomb itself.

<h2>Strategies</h2>
Strategies range from the examples given above of code that replicates itself or bombs other programs, to code that scans for other programs before disabling them or killing them.  Decoys can be used to fool the scanners and you can combine strategies to increase effectiveness.  The latest developments are self-repairing code and battle programs that have been evolved.  The possibilities really are endless.


<h2>Competing and Other Activities</h2>
There are a number of ways that you can compete and add interest to REDCODE programming:
<ul>
<li>You can run other peoples' programs against your own via a simulator on your computer.</li>
<li>Once you have created an effective battle program you could submit it to a hill such as <a href="http://www.koth.org/index.html">King of the Hill</a>, where it will compete against other battle programs.</li>
<li>Engage in <a href="http://labarga.atspace.com/mc.html">The Mini Challenge</a>, where specific programming challenges are set.</li>
<li>You can use the constraints placed upon the programmer by REDCODE as an interesting platform to experiment with.  This is the focus of a lot of the posts on <a href="http://impomatic.blogspot.com/">Thoughts on Corewar...</a>.</li>
</ul>

<h2>Where Now?</h2>
To begin you will need to download a simulator such as <a href="http://sourceforge.net/projects/corewar">pMARS</a> and a tutorial such as <a href="http://vyznev.net/corewar/guide.html">The beginners' guide to Redcode</a>.  Further information can be found at the excellent site: <a href="http://www.corewar.co.uk/">Corewar - the war of the programmers</a>.

I must warn you before you try it yourselves; it is incredibly addictive as you will nearly always want to make just one more tweak to improve a battle program.  Have fun, but remember it is only a game.
