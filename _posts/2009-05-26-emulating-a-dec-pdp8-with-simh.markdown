---
layout: article
title: "Emulating a DEC PDP-8 with SimH"
summaryPic: small_dec_pdp8-fpanel.jpg
tags:
  - Emulation
  - DEC
  - PDP-8
  - Retro
  - SimH
  - Tutorial
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
The DEC PDP-8 mini-computer was launched on 22 March 1965 and was a great success.  It was fairly cheap for the day and could easily be expanded.  What attracts me most to the PDP-8 is its simple design.  I therefore decided to experiment with the SimH emulation of this machine, but found that the documentation wasn't always straightforward.  This article intends to show how easy SimH is and how powerful it can be.

<h2>Obtaining SimH</h2>
SimH can be obtained from <a href="http://simh.trailing-edge.com/">The Computer History Simulation Project</a>.  It is available as a Windows executable or as source code which can be compiled on many different systems.  In addition it is included with most Linux distributions.  SimH actually emulates a number of computer systems, and all are included.


<h2>Starting the PDP-8 SimH Emulator</h2>
SimH is very easy to use once you get the hang of the way that it works.  The PDP-8 emulator is started with the command: `pdp8`.  The first thing that you generally see is the version of the simulator followed by the `sim>` prompt.  At this prompt you can control the simulated hardware of the machine, configure various options and once you start a program it will be taken over by the Console Input/Output of the emulated computer.

SimH will allow you to run a PDP-8 just using the front panel switches, or you can use simulated paper tape and a teletype, as well as a number of other devices.  Some programs run directly on the PDP-8 and there are a few operating systems available with their associated software.

Once you have had enough, you can exit the emulator with the following command at the `sim>` prompt:

    exit                         Returns to host Operating System

<h2>Configuring the Emulator</h2>
SimH is highly configurable and has a number of options which can be set from the <em>sim&gt;</em> command prompt.  Below are the most useful to start with.


<h3>Controlling the Emulation Speed</h3>
On some host machines, the emulator can be made more realistic by slowing down the speed of execution.  This is done using one of the following commands:

    set throttle xM              Set execution rate to x mips
    set throttle xK              Set execution rate to x kips
    set throttle x%              Limit simulator to x% of host time
    set nothrottle               Turn off throttling

<h3>Reducing Resource Use on the Host Machine</h3>
Some host machines support the following command to control how resources are used.

    set cpu idle                 Reduces drain on host machine when emulated cpu is idle
    set cpu noidle               Constant drain on host machine

<h3>Connecting the Console to a Telnet Port</h3>
If you wish to connect the output of the console to a telnet port, this can be done with the following:

    set console telnet=<port>    Connect console terminal to Telnet session on port
    set console notelnet         Disable console Telnet

<h3>Automating the Configuration</h3>
The above configuration options can be stored in a file so that each time the PDP-8 emulator is started, they will take effect.  To do this put any of the options above into a file called `pdp8.ini`.  Now when the PDP-8 emulator is started, it will look to see if the file `pdp8.ini` is in the current directory, if it is then the lines from it will be read in just as if you had typed them at the `sim>` prompt.

<h4>Example pdp8.ini file</h4>
If the following lines are put in a file called `pdp8.ini`, the emulator will not hog so many resources on the host system, will emulate at 500,000 Instructions Per Second and the console will be reachable through telnet on port 18977.  However, not all of these settings will work on all machines.

{% highlight text %}
set cpu idle
set throttling 500k 
set console telnet=18977
{% endhighlight %}

<h2>Devices</h2>
SimH can emulate a large number of the devices that were attached to the PDP-8.  Each of these devices can be connected to a file on the host system, e.g. The line Printer (LPT) could be connected to a file called `print.out` and then if anything was printed from the PDP-8, it would go to that file.  The most important devices for the purpose of this article and up-coming ones are:

<table class="neatTable">
<tr><th>Unit</th><th>Description</th></tr>
<tr><td>PTR</td><td>High-Speed Paper Tape Reader</td></tr>
<tr><td>PTP</td><td>High-Speed Paper Tape Punch</td></tr>
<tr><td>LPT</td><td>Line Printer</td></tr>
<tr><td>RX</td><td>Floppy Disk (RX01 and RX02)</td></tr>
<tr><td>RF</td><td>Fixed Head Disk</td></tr>
<tr><td>DT</td><td>DECtape (DT00 to DT07)</td></tr>
</table>

Devices can be connected to files or disconnected with the following commands:

    attach <unit> <filename>
    detach <unit>


<h2>Octal Addressing</h2>
The natural way of abbreviating binary numbers on the PDP-8 is in octal.  This is a base 8 number system where each octal digit represents 3 bits.  The machine uses 12-bit addressing and hence 4 octal digits represent these 12 bits.  When these bits are referred to it must be remembered that the PDP-8 uses big-endian bit numbering (that is, bit 0, the left most bit, is the most significant).


<h2>Low-level Access to the Machine</h2>
The PDP-8 often required you to access registers and memory addresses directly and it was particularly common for software to require you to configure certain option by setting the front panel switches.  Below are the most important registers that can be set through SimH:

<table class="neatTable">
<tr><th>Name</th><th>Size in bits</th><th>Description</th></tr>
<tr><td>PC</td><td>15</td><td>Program Counter, including IF as high 3 bits</td></tr>
<tr><td>AC</td><td>12</td><td>Accumulator</td></tr>
<tr><td>L</td><td>1</td><td>Link</td></tr>
<tr><td>MQ</td><td>12</td><td>Multiplier Quotient</td></tr>
<tr><td>IF</td><td>3</td><td>Instruction Field</td></tr>
<tr><td>DF</td><td>3</td><td>Date Field</td></tr>
<tr><td>SR</td><td>12</td><td>Switch Register (Front Panel Switches)</td></tr>
</table>

<h3>Commands to Change/Examine Memory/Registers</h3>
There are two main commands that can be used to change or examine memory locations and registers:


    examine <Register|Memory Location>              Examine a Register|Memory Location
    deposit <Register|Memory Location> <Value>      Deposit Value in the Register|Memory Location

To make this easier, `examine` can be abbreviated to `e` and `depost` can be abbreviated to `d`.

<h2>Controlling Programs</h2>
There are a number of commands to start a program running and control its execution:

    run [<address>]              Resets all devices and starts execution at address 
                                 or PC if address not specified
    go [<address>]               As above, but doesn't reset devices
    cont                         Does not reset devices and continues execution at PC
    boot <unit>                  Resets all devices and bootstraps the device and unit given by its argument. 
                                 If no unit is supplied, unit 0 is bootstrapped

On a real PDP-8 to load a program the first step is often to enter a short program via the front-panel switches that loads paper tape in _RIM_ format.  This is then generally used to load a Binary Loader program via paper tape.  This Binary Loader can then load programs via paper tape in _BIN_ format.  The _BIN_ format is normally used for programs as it is more compact.  You could follow this process with SimH, but there are some shortcuts to make things easier:

    load -r <filename>           Loads a file from the host system in RIM format
    load <filename>              Loads a file from the host system in BIN format

You can use CTRL+E to get back to the `sim>` prompt when talking to the emulated PDP-8 via the Console Input/Output.  This is defined by the `WRU` (Where are you) console option and is initially set to `005` (CTRL+E).  To continue execution you would just use the `cont` command above.


<h2>FOCAL-69</h2>
To give a quick demonstration of SimH, I have chosen to use FOCAL-69.  FOCAL-69 was an important version of the FOCAL (FOrmula CALculator) programming language, created by Richard Merrill.  It would run even on systems with only 4K of memory but could use more if available.  A copy of the <a href="http://www.cs.uiowa.edu/~jones/pdp8/focal/focal69.html">FOCAL-69 Promotional Booklet</a> is available from <a href="http://www.cs.uiowa.edu/~jones/pdp8/">Douglas W. Jones's PDP-8 page</a> and a <a href="http://simh.trailing-edge.com/kits/foclswre.tar.Z">FOCAL-69 binary paper tape image</a> is available from the <a href="http://simh.trailing-edge.com/software.html ">SimH Software Kits Page</a>.

To try out FOCAL-69 in the PDP-8 emulator, first uncompress the file containing the FOCAL-69 binary paper tape image downloaded above.  This will give you a file called `focal69.bin`.  Now run, `pdp8` in the directory in which `focal69.bin` is located.

To load the paper tape image into memory type:
{% highlight text %}
sim> load focal69.bin
{% endhighlight %}

Programs loaded from paper tape in binary format often start at Octal address 200 and this is the case here.  To start the program run:
{% highlight text %}
sim> run 200
{% endhighlight %}

FOCAL-69 will now start and present you with the `*` prompt.  To say hello to the world type the following excluding the `*` which is the prompt:
{% highlight text %}
* _TYPE "HELLO, WORLD"
{% endhighlight %}


<h2>Where Now?</h2>
More information is available at the <a href="http://simh.trailing-edge.com/">The Computer History Simulation Project</a>, particularly on the <a href="http://simh.trailing-edge.com/pdf/all_docs.html">Simulator Documentation</a> page.  There are several <a href="http://simh.trailing-edge.com/software.html">software kits</a> available to run on the PDP-8 and documentation for these can be found on the <a href="http://simh.trailing-edge.com/pdf/all_docs.html">Simulator Documentation</a> page.  Another good source of software and documentation is at <a href="http://bitsavers.org/">bitsavers.org</a>.

I will shortly be writing some more articles on the PDP-8, so stay tuned.

