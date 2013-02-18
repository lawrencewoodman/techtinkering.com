---
layout: article
title: "Installing the HI-TECH Z80 C Compiler for CP/M"
summaryPic: small_war_c.png
tags:
  - C
  - CP/M
  - Programming
  - Retro
  - Z80
  - Tutorial
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
edited: 2012-12-11
licence: cc_attrib
---
My language of choice is C and I am currently getting more involved with the CP/M operating system.  I have therefore decided that it would be nice to have a C compiler working under CP/M.  There are a number of options available in the archives, but I have found that [HI-TECH](http://www.hitech.com.au/) are allowing their CP/M C Compiler to be downloaded for free.  This is a very good product, has good documentation, is almost ANSI C compliant and can be used for commercial and non-commercial use.  This, therefore, is the one I have chosen.

## Downloading the HI-TECH Z80 CP/M C Compiler
At one time this could be downloaded from the HI-TECH site, however the best place to get it from now is [z80.eu](http://www.z80.eu/c-compiler.html).

The files are self-extracting lharc'ed archives so I installed [lha](http://www.infor.kanazawa-it.ac.jp/~ishii/lhaunix/), which is part of my Debian distro.  To extract the contents of the main compiler archive, I created a subdirectory called `z80v309`.  I entered it and ran:
{% highlight bash %}$ lha e ../z80v309.exe{% endhighlight %}

The extracted contents comes to 413k which is too large for the 8" SD disks that my emulator supports, so I used [Cpmtools](http://www.moria.de/~michael/cpmtools/) to create a 4Mb HDD image to put the files on.  Hopefully however, this should fit on your disks. 

## Using the C compiler
To test the C compiler I went to the B: drive, where I'm storing my development work, and created a file called `hello.c` containing the classic "hello, world" source code:

{% highlight c %}
void main(void)
{
   printf("hello, world\n");
}
{% endhighlight %}

To compile the source (`hello.c` on my B: drive) in verbose mode, using the compiler on my I: drive, I run the following:
{% highlight text %}I> c -v b:hello.c{% endhighlight %}

This leaves the executable `hello.com` on the I: drive.  Now all we need to do is run it to ensure that it has compiled properly:
{% highlight text %}I> hello{% endhighlight %}

Which gives the correct output as below:

<pre><samp>hello, world</samp></pre>

## Where Now?
The next step, if you haven't already done it, is to extract the documentation file, `z80doc.exe`.  This is an extensive document that should really help you get to grips with using the compiler.  Now all you have to do is start tinkering and see what you can create. 
