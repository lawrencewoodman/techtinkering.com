---
layout: article
title: "Using the latest  z80pack, version 1.17, to emulate an Altair 8800 or IMSAI 8080 using the new graphical FrontPanel"
summaryPic: small_imsai_frontpanel_z80pack.jpg
summaryPicTitle: "Screenshot of z80pack using FrontPanel to emulate an IMSAI 8080"
tags:
  - 8080
  - Emulation
  - Retro
  - Tutorial
  - Altair
  - IMSAI
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

Udo Munk has just released the latest version of his [z80pack](http://www.unix4fun.org/z80pack/) emulator, version 1.17, which now includes John Kichury's FrontPanel library.  As well as being a superb emulator to run CP/M on, it now gives you a great graphical representation of the [Altair 8800](http://en.wikipedia.org/wiki/Altair_8800 "Altair 8800 Wikipedia Article") and [IMSAI 8080](http://en.wikipedia.org/wiki/IMSAI_8080 "IMSAI 8080 Wikipedia Article") with fully functional switches and flashing lights.  If you've ever wondered what it would be like to use one of these machines, why not give it a try?

## Installing z80pack
The following installation instructions are only for the Altair 8800 and IMSAI 8080 systems.  For installation instructions of the complete system, why not have a look at my previous article: [Setting up z80pack to create an emulated CP/M system](/2008/10/17/setting-up-z80pack-to-create-an-emulated-cpm-system).

* First download the source (z80pack-x.y.tgz, currently z80pack-1.17.tgz) for [z80pack](http://www.unix4fun.org/z80pack/ "z80pack main site") from its [ftp site](ftp://ftp.unix4fun.org/z80pack).  The following [installation instructions](http://www.unix4fun.org/z80pack/#dri_quick "Installation instructions for z80pack") are taken from the z80pack site.  More information can be found there, in particular, information on installing z80pack on non Linux/Unix systems.

* Unpack the source archive in your home directory:
  {% highlight bash %}$ tar xzvf z80pack-x.y.tgz{% endhighlight %}
* Change the directory it is extracted to, to make this article easier to explain.  There is no need for you to do this.
  {% highlight bash %}$ mv z80pack-1.17 z80pack{% endhighlight %}
* Compile the FrontPanel library:
  {% highlight bash %}
    $ cd ~/z80pack/frontpanel
    $ make{% endhighlight %}
* Copy the front panel library to `/usr/lib`
  {% highlight bash %}$ cp libfrontpanel.so /usr/lib/{% endhighlight %}
* Compile the Altair 8800 emulator:
  {% highlight bash %}
    $ cd ~/z80pack/altairsim/srcsim
    $ make
    $ make clean{% endhighlight %}
* Compile the IMSAI 8080 emulator:
  {% highlight bash %}
    $ cd ~/z80pack/imsaisim/srcsim
    $ make
    $ make clean{% endhighlight %}
* I don't like the 3D version of the IMSAI, so I changed it to 2D:
  {% highlight bash %}
    $ cd ~/z80pack/imsaisim
    $ rm conf
    $ ln -s conf_2d conf{% endhighlight %}

## Getting Altair and IMSAI documentation
The z80pack ftp site has some documentation for the Altair and IMSAI machines which has been scanned in from the originals.  For the Altair there is the [Altair 8800 Operator's Manual](ftp://ftp.unix4fun.org/z80pack/altair/88opman.pdf) and for the IMSAI there is the [IMSAI 8080 User's Manual](ftp://ftp.unix4fun.org/z80pack/imsai/IMSAI-8080_manual.pdf).  There is also some other relevant documentation and files in the [altair](ftp://ftp.unix4fun.org/z80pack/altair) and [imsai](ftp://ftp.unix4fun.org/z80pack/imsai) ftp directories.

## Running a test program on the IMSAI 8080
To start the IMSAI 8080 emulator:
{% highlight bash %}
$ cd ~/z80pack/imsaisim
$ imsaisim
{% endhighlight %}

The IMSAI 8080 front panel:

<img src="/images/posts/imsai_frontpanel_z80pack.jpg" title="Screenshot of z80pack using FrontPanel to emulate an IMSAI 8080"/>

The example program we are going to use is taken from the IMSAI 8080 User's Manual mentioned above and can be found from page 19.  The program takes input from the _PROGRAMMED INPUT_ switches at the bottom left of the unit and outputs it to the _PROGRAMMED OUTPUT_ at the top left.

<table style="clear: left;" class="neatTable">
<tr><th>Address</th><th>Hex</th><th>Binary</th><th> </th></tr>
<tr><td>0</td><td>DB</td><td>1101 1011</td><td>IN    - Input into Accumulator</td></tr>
<tr><td>1</td><td>FF</td><td>1111 1111</td><td>Address of Programmed I/O Port to get input from</td></tr>
<tr><td>2</td><td>2F</td><td>0010 1111</td><td>CMA - Complement Data in Accumulator</td></tr>
<tr><td>3</td><td>D3</td><td>1101 0011</td><td>OUT - Output Data from Accumulator</td></tr>
<tr><td>4</td><td>FF</td><td>1111 1111</td><td>Address of Programmed I/O Port to put output to</td></tr>
<tr><td>5</td><td>C3</td><td>1100 0011</td><td>JMP - Jump</td></tr>
<tr><td>6</td><td>00</td><td>0000 0000</td><td>Low Address of beginning of program</td></tr>
<tr><td>7</td><td>00</td><td>0000 0000</td><td>High Address of beginning of program</td></tr>
</table>

To enter the program follow these instructions:

1. Turn the machine on by moving the _PWR ON / PWR OFF_ switch to _PWR ON_.  This switch is located at the far-right of the unit.
2. The machine is now at address 0.  To input the first line of the program move the middle set of switches so that positions 7,6,4,3,1,0 are down.  This corresponds to binary: 1101 1011 from Address 0 of the program.
3. Press the _DEPOSIT / DEPOSIT NEXT_ switch into the _DEPOST_ position.  This puts the data from the switches set above into memory at the current address, which is currently 0.
4. Set the middle group of switches so that it corresponds to the binary in the next line of the program.
5. Press the _DEPOST / DEPOSIT NEXT_ switch into the _DEPOSIT NEXT_ position.  This increments the current address, and there it puts the data from the switches just set.
6. Repeat lines 4 and 5 until the program has been entered.

The program can now be run by moving the _RUN / STOP_ switch into the _RUN_ position.  If you now move any of the _PROGRAMMED INPUT_ switches, you will see them represented in the lights of the _PROGRAMMED OUTPUT_.  Congratulations, you may have just run your first program on the IMSAI 8080.


## Where Now?
There is plenty of information in the manuals I have mentioned, and these should be your first port of call.  The Altair 8800 Operator's Manual has a similar example to the one given for the IMSAI, and begins on page 33.  You may also be interested in my next article: [Writing My First Program to Toggle in to the IMSAI 8080](/2008/11/05/writing-my-first-program-to-toggle-in-to-the-imsai-8080/).  Have fun, and I hope your mouse finger doesn't get sore clicking all those switches!
