---
layout: article
title: "Running 4K FORTRAN on a DEC PDP-8"
summaryPic: small_fortran_source.jpg
tags:
  - DEC
  - Retro
  - PDP-8
  - FORTRAN
  - Programming
  - Tutorial
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

4K FORTRAN was a subset of FORTRAN II and was the first high-level language available for the DEC PDP-8.  It consisted of two parts: the 4K FORTRAN Compiler (nicknamed "Fivetran") and the 4K FORTRAN Operating System.  The compiler was written by Larry Portner and the operating system was written by Henry Burkhardt.  The introduction of this compiler made the PDP-8 much easier to program and was particularly useful to those using the machine for scientific calculations.  Below is a guide to using 4K FORTRAN.

<h2>Obtaining 4K FORTRAN and Its Manual</h2>
The following files are all from <a href="http://bitsavers.org">Bitsavers</a>.  The 4K FORTRAN compiler is available as a paper-tape image called: <a href="http://bitsavers.org/bits/DEC/pdp8/papertapeImages/set2/tray3/dec-08-afc1-pb_9-13-67.bin">dec-08-afc1-pb_9-13-67.bin</a>, and the 4K FORTRAN operating system is also available as a paper-tape image called: <a href="http://bitsavers.org/bits/DEC/pdp8/papertapeImages/set2/tray3/dec-08-afc3-pb_8-67.bin">dec-08-afc3-pb_8-67.bin</a>.  In addition, the <a href="http://www.bitsavers.org/pdf/dec/pdp8/software/DEC-08-AFCO-D_4K_FORTRAN.pdf">4K FORTRAN Programmers Reference Manual (May 1969)</a> is available in PDF format.


<h2>Compiling Source Code</h2>
Once you have written some Fortran source code and committed it to paper-tape, you are ready to compile it.  For more information on how to create and edit source code on paper-tape, have a look at my article: <a href="/2009/06/16/a-quickstart-guide-to-editing-paper-tape-with-the-symbolic-tape-editor-on-the-dec-pdp-8/">A Quickstart Guide to Editing Paper Tape with the Symbolic Tape Editor on the DEC PDP-8</a>.

<h3>Example Source Code</h3>
Below is a simple piece of source code that calculates factorials.  It can be entered using the Symbolic Tape Editor mentioned above.  For those familiar with Fortran, note the non-standard use of semi-colons after labels, this is because the source is written on free-form paper tape not punched cards.

{% highlight fortran %}
C;      THIS PROGRAM CALCULATES FACTORIALS
5;      TYPE 200
10;     ACCEPT 300,X
        FACT=Y=1.
        IF (X) 5,32,30
30;     IF (X-Y) 41,32,33
32;     TYPE 400,X,FACT
        GO TO 10
33;     FACT=FACT*(Y=Y+1.)
        GO TO 30
41;     PAUSE
        GO TO 5
200;    FORMAT (/, "PLEASE TYPE A POSITIVE NUMBER", /)
300;    FORMAT (E)
400;    FORMAT (/,E, "FACTORIAL IS",E)
        END
{% endhighlight %}

<h3>Instructions for Owners of a Real PDP-8</h3>
To load the compiler from paper-tape on a real PDP-8 just load the Binary Loader first and then the compiler from paper-tape in the normal way.  Now attach the source code paper-tape to the paper-tape reader and some blank tape for the object code to the paper-tape punch.  The compiler can then be started at Octal address 200.  If you have a high-speed punch or reader then you will want to set Switch Register bit 1 to high for a high-speed reader and bit 2 to high for a high-speed punch (See appendix C of the Fortran Manual).

<h3>Instructions for Those Using SimH to Emulate a PDP-8</h3>

To load the compiler's paper-tape image from the current directory:
{% highlight text %}sim> load dec-08-afc1-pb_9-13-67.bin{% endhighlight %}

SimH emulates a high-speed punch and reader, so you will want to set Switch Register bits 1 &amp; 2 to high to tell the compiler that this is what you will be using.
{% highlight text %}sim> de sr 3000{% endhighlight %}

Attach the Fortran source code to the paper tape reader.  In this case we could attach the paper-tape image of the factorials source code from the example above:
{% highlight text %}sim> attach ptr factorials.ft{% endhighlight %}

Attach a blank file to the paper tape punch, to store the object code produced by the compiler:
{% highlight text %}sim> attach ptp factorials.f.bin{% endhighlight %}

To run the compiler on the source (200 here is in Octal):
{% highlight text %}sim> run 200{% endhighlight %}

<h2>Running the Compiled Code in the 4K FORTRAN Operating System (Object Time System)</h2>
The code that is produced from the compiler can't be run on its own, it has to be run through the 4K FORTRAN Operating System.  This seems like a pain to start with, but once you get used to it, you will find that it gives you more flexible control over the devices attached to the PDP-8, without having to re-write your Fortran programs.

<h3>Instructions for Owners of a Real PDP-8</h3>
Load the operating system from paper-tape via the Binary Loader in the normal way.  If you have a high-speed punch or reader then you will want to set Switch Register bit 1 to high for a high-speed reader and bit 2 to high for a high-speed punch (See appendix C of the Fortran Manual).  Now attach the object code paper-tape to the paper-tape reader.  When the operating system is started at Octal address 200, it will load in the object code tape and halt.  To set the operating system to use the teletype for `ACCEPT` and `TYPE` statements (user I/O) set bits 1 & 2 to low.  All you have to do now to execute the object code is press `CONTINUE`, and if you want to run it a second time just start execution again at Octal address 201.


<h3>Instructions for Those Using SimH to Emulate a PDP-8</h3>

If you have not already done so disconnect the paper-tape images from the reader and punch:
{% highlight text %}sim> detach ptr{% endhighlight %}
{% highlight text %}sim> detach ptp{% endhighlight %}


To load the Operating System's paper-tape image from the current directory:
{% highlight text %}sim> load dec-08-afc3-pb_8-67.bin{% endhighlight %}


Set the operating system to use the high-speed punch and high-speed reader:
{% highlight text %}sim> de sr 3000{% endhighlight %}


Attach the object code produced by the compiler to the paper tape reader.  In this case we could attach the paper-tape image of object code produced from the factorials source code above:
{% highlight text %}sim> attach ptr factorials.f.bin{% endhighlight %}


Start the fortran operating system, which will load in the object code tape and halt:
{% highlight text %}sim> run 200{% endhighlight %}


To set the operating system to use the teletype for ACCEPT and TYPE statements (user I/O):
{% highlight text %}sim> de sr 0000{% endhighlight %}


To execute the object code:
{% highlight text %}sim> cont{% endhighlight %}

To run the object code again:
{% highlight text %}sim> run 201{% endhighlight %}


<h2>Where Now?</h2>
As you have seen, basic operation of the Fortran compiler is quite simple.  Beyond this there is quite a bit more that can be done, such as using DECtape for processing data.  The 4K FORTRAN manual does a good job of explaining how to use the compiler and operating system, as well as teaching this variant of Fortran.  If you haven't used SimH before, take a look at my article: <a href="/2009/05/26/emulating-a-dec-pdp8-with-simh/">Emulating a DEC PDP-8 with SimH</a>.  As always, I would be interested to hear what you do with this.
