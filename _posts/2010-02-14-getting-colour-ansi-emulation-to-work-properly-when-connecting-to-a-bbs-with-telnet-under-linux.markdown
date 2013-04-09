---
layout: article
title: "Getting Colour ANSI Emulation to Work Properly When Connecting to a BBS With Telnet Under Linux"
summaryPic: small_bbs_splashscreen.jpg
summaryTitle: "A BBS Splash Screen"
tags:
  - Linux
  - Retro
  - ANSI
  - Text Mode
  - Tutorial
  - BBS
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
I have noticed that the number of people interested in using telnet to access BBSs
seems to be growing, which I'm really pleased to see.  However lots of people seem to
be having trouble getting colour ANSI emulation working properly with telnet under Linux. 
I have therefore put this tutorial together to show just how easy it is.

The process of getting colour ANSI emulation working properly in telnet is quite simple.
All you need is the correct font and be using the correct terminal emulation mode.
This is easily done as follows:

## Installing the Correct Fonts

*   Download the correct fonts from [here](/downloads/ansifonts.tar.gz "Save this file to your local machine"), so that you can display the ANSI block characters properly.
*   Check where your X fonts are stored, under Debian Lenny I would use `/usr/share/fonts/X11/misc`.
*   As root extract the archive downloaded above to the font directory using:
    {% highlight bash %}$ tar -xvzf ansifonts.tar.gz -C /usr/share/fonts/X11/misc{% endhighlight %}
*   Ensure that X knows about the fonts:
    {% highlight bash %}$ mkfontdir /usr/share/fonts/X11/misc/
    $ xset fp rehash{% endhighlight %}
*   Check that X now knows about the fonts (Should return at least one line with the text '`vga11x19`'):
    {% highlight bash %}$ xlsfonts | grep vga11x19{% endhighlight %}

## Setting Up Your Terminal Emulator
The only terminal emulator I could found that does ANSI colour emulation properly is `rxvt`, if you haven't already got this installed then now is the time to do that.  You now need to make sure that your terminal emulator is using one of the correct fonts.  To start `rxvt` with the `vga11x19` font, a black background and white foreground, type:
{% highlight bash %}$ rxvt -fn vga11x19 -bg black -fg white &{% endhighlight %}

Now you need to make sure that `rxvt` is emulating an ANSI display.  To do this you need to set the `TERM` and `COLORTERM` environmental variables to 'ansi'.  If you are using the `bash` shell type the following from within the `rxvt` window:
{% highlight bash %}
$ export TERM=ansi
$ export COLORTERM=ansi
{% endhighlight %}

<h2>Connecting to BBSs with Telnet</h2>
Now you can just telnet as normal to the BBS you are interested in.  If you wanted to connect to a made-up BBS called `somebbs.com`:
{% highlight bash %}$ telnet somebbs.com{% endhighlight %}

There is quite a lot of information on the internet about telnet BBSs, some of the best sites are: <a href="http://www.bbscorner.com/">BBS Corner</a>, <a href="http://www.bbsfinder.com/">BBS Finder</a>, <a href="http://www.telnetbbsguide.com/">The Telnet BBS Guide</a> and <a href="http://bbs-scene.org/">BBS Scene</a>.  Have fun, and I hope we can expand the use of BBSs, as I still believe they have a lot to give.

