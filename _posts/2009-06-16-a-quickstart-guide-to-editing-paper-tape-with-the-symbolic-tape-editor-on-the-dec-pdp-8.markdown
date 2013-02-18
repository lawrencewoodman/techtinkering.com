---
layout: article
title: "A Quickstart Guide to Editing Paper Tape With the Symbolic Tape Editor on the DEC PDP-8"
summaryPic: small_paper_tape.jpg
tags:
  - DEC
  - Retro
  - PDP-8
  - Editors
  - Tutorial
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
Before re-writable storage devices, such as tape drives, become popular for the DEC PDP-8, owners had to rely on paper tape.  This was fine for loading programs on pre-punched tape, but left the problem of how to put new data onto punched tape and how to edit existing data.  This could be done off-line, but a better way was to use DEC's Symbolic Editor.  This made life much easier as it allowed you to interactively edit a tape in a buffer, check the alterations and then output a new tape.  This editor was used for quite a few years by those wanting to edit Assembly or FORTRAN source code.  What follows is a brief introduction to using this editor.

<h2>Obtaining the Symbolic Editor and Its Manual</h2>
The Symbolic Editor can be obtained from, the invaluable resource for retro software and documentation, <a href="http://bitsavers.org">Bitsavers</a>.  The paper-tape image is called: <a href="http://bitsavers.org/bits/DEC/pdp8/From_pdp8.hachti.de/hachti-pdp8-tapes/DEC-08-ESAB-PB.bin">DEC-08-ESAB-PB.bin</a>.  This file is loadable by emulators such as SimH, but owners of a real PDP-8 will have to find a way to punch this image to paper-tape.  The <a href="http://www.bitsavers.org/pdf/dec/pdp8/software/DEC-08-ESAB-D_EDITOR_Man.pdf">Symbolic Editor Programming Manual</a> is also available from bitsavers in PDF format.

<h2>Theory of Operation</h2>
The editor works by containing the text you are editing in a buffer in memory referred to as a page.  So when you read in a paper-tape, it will read as much as it can into the free memory and then ring a bell to indicate that you may begin editing.  You can then edit this text and write it to a new paper tape.

The editor works a bit like the Unix editor, vi, in that it has two modes of operation: _command mode_ and _text mode_.  When in _command mode_ all text typed via the teletype is interpreted as text editing commands.  When in _text mode_ all text typed in via the teletype is either adding to or altering the text in the buffer.

When the editor is first loaded it starts off in _command mode_, you can then type your desired command followed by `RETURN` to action it.  Depending on the command, the editor may now switch to _text mode_ and allow you to edit the buffer.

When in _text mode_ you must press `RETURN` after each line that you enter to save it to the buffer.  To return to _command mode_ and to cancel the current line you are typing press `CTRL+FORM` (`CTRL+L`).

<h2>Starting the Editor</h2>
<h3>Instructions for Owners of a Real PDP-8</h3>
To load the editor from paper-tape on a real PDP-8 just load the Binary Loader first and then the editor from paper-tape in the normal way.  The program can then be started at Octal address 200.  If you have a high-speed punch or reader then you will want to set Switch Register bit 10 to high for a high-speed punch and bit 11 to high for a high-speed reader (See section 1.4 of Symbolic Editor Programming Manual).

<h3>Instructions for Those Using SimH to Emulate a PDP-8</h3>
If you are using SimH, then the following applies:

To load the editor's paper-tape image from the current directory in SimH:
{% highlight text %}sim> load DEC-08-ESAB-PB.bin{% endhighlight %}

SimH emulates a high-speed punch and reader, so you will want to set Switch Register bits `10` and `11` to high to tell the editor that this is what you will be using:
{% highlight text %}sim> de sr 3{% endhighlight %}

To run the editor (`200` here is in Octal):
{% highlight text %}sim> run 200{% endhighlight %}


<h2>Commands</h2>
The commands take the following form where `E` represents any command:
<table class="neatTable">
<tr><th>Command Structure</th><th>Purpose</th></tr>
<tr><td>E</td><td>Perform command <em>E</em></td></tr>
<tr><td>nE</td><td>Perform command <em>E</em> on line <em>n</em></td></tr>
<tr><td>m,nE</td><td>Perform command <em>E</em> on lines <em>m</em> to <em>n</em>, inclusive.</td></tr>
</table>


Below is a brief list of useful commands to get you started:
<table class="neatTable">
<tr><th>Command</th><th>Description</th></tr>
<tr><td>A</td><td>Appends the text from the teletype to the buffer, if the buffer is blank then this can be used to create a new paper-tape</td></tr>
<tr><td>C</td><td>Changes the specified line or range of lines</td></tr>
<tr><td>D</td><td>Deletes a line or range of lines from the buffer</td></tr>
<tr><td>I</td><td>Inserts text before line 1 or before the specified line</td></tr>
<tr><td>K</td><td>Kill the entire page buffer</td></tr>
<tr><td>L</td><td>Lists a page, line or range of lines from the buffer</td></tr>
<tr><td>P</td><td>Punches the contents of the buffer, line or range of lines to the paper-tape punch</td></tr>
<tr><td>R</td><td>Reads a page of text from the paper-tape reader and appends it to the buffer</td></tr>
</table>

<h2>Examples</h2>

<h3>Creating a new paper-tape with source code for a FORTRAN program</h3>

Start the Editor as above, note that when it is started it doesn't come up with a prompt, so don't worry if it looks as if it isn't doing anything.

Owners of a real PDP-8, attach a blank piece of paper-tape to the punch.
If using SimH, then press `CTRL+E` to get to the `sim>` prompt and attach a file to the paper-tape punch:
{% highlight text %}sim> attach ptp factorials.ft{% endhighlight %}
To get back to the editor:
{% highlight text %}sim> cont{% endhighlight %}

The editor starts with a blank buffer.  To append the following source code to it, use the command: `A`, and then enter:
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
Remember to press `RETURN` after each line including the last line to make sure that it is saved to the buffer.

Press `CTRL+FORM` (`CTRL+L`) to go back to command mode.

Test some of the commands such as: `1,5L`, to list the first 5 lines in the buffer.

Punch the buffer to paper-tape with the command: `P`

<h3>Reading an existing paper-tape into the editor</h3>

If the editor isn't already started do so as above, otherwise use the command: `K` to clear the contents of the buffer.

Owners of a real PDP-8, attach the paper-tape that you want to edit to the paper-tape reader.
If using SimH, then press CTRL+E to get to the `sim>` prompt.

If you haven't already detached the file above from the paper-tape punch then:
{% highlight text %}sim> detach ptp{% endhighlight %}

To attach the file we made previously to the paper-tape reader:
{% highlight text %}sim> attach ptr factorials.ft{% endhighlight %}

To get back to the editor:
{% highlight text %}sim> cont{% endhighlight %}

Read the paper-tape into the buffer with the command: `R`

List its contents with the command: `L`

<h2>Where Now?</h2>
This editor can be really quite flexible and you can even create separate tape editing tapes which will automatically run the tape editors commands over a tape to be edited.  More information can be found by reading the <a href="http://www.bitsavers.org/pdf/dec/pdp8/software/DEC-08-ESAB-D_EDITOR_Man.pdf">Symbolic Editor Programming Manual</a>.  In addition if you haven't used SimH before, take a look at my article: <a href="/2009/05/26/emulating-a-dec-pdp8-with-simh/">Emulating a DEC PDP-8 with SimH</a>.  I intend to follow this article with some further articles on programming the PDP-8 and will be using this editor to do this shortly.
