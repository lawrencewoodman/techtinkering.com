---
layout: article
title: "Using DOSBox to Run DOS Games and Applications"
summaryPic: small_cnc_ingame.png
summaryPicTitle: "Command and Conquer In-Game Screenshot"
tags:
  - DOS
  - Emulation
  - Retro
  - Tutorial
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
There were some brilliant games and applications released for DOS, and some of the games such as Command and Conquer are still very playable.  There are a number of options to play these games today, from using a Virtual Machine such as [QEMU](http://bellard.org/qemu/), to [DOSBox](http://dosbox.com) which is a dedicated DOS emulator.  Both of these are included in most Linux distributions.  I have chosen DOSBox as it is quick and very easy to use, you don't need to install a DOS compatible operating system on it, and it uses your native file system for storage.

## Configuring DOSBox
If DOSBox isn't included with your Linux distribution then it can be obtained from the [download](http://www.dosbox.com/download.php?main=1) section of their site.  Below is a quick example of how to configure DOSBox once you have it installed.  More information can be found by looking at the [Installation Instructions](http://www.dosbox.com/wiki/Basic_Setup_and_Installation_of_DosBox) on the emulator's site.

First create a directory to store you DOS files in:
{% highlight bash %}$ mkdir ~/dos_c{% endhighlight %}

Now run DOSBox from your home directory:
{% highlight bash %}$ dosbox{% endhighlight %}

You should see a screen similar to the following:

<img style="clear: right;" width="482" height="300" src="/images/posts/dosbox.png" title="DOSBox Startup Screen" alt="Picture of DOSBox Startup Screen"/>

From within the DOSBox emulation window create a `dosbox.conf` file in the current native directory:
{% highlight text %}Z:\> CONFIG -writeconf dosbox.conf{% endhighlight %}

Leave DOSBox:
{% highlight text %}Z:> exit{% endhighlight %}

To get DOSBox to automatically mount the `~/dos_c` directory as drive C:, add the following lines to `dosbox.conf`:
{% highlight text %}
mount c ~/dos_c
c:
{% endhighlight %}


## Installing Software on DOSBox
Now comes the real beauty of DOSBox.  All you have to do is put your games or applications in `~/dos_c`, start DOSBox, and they will be on the C: drive.

### An Example Using Command and Conquer
As an example I have chosen to use Command and Conquer.  This is available from the [Abandonia](http://www.abandonia.com) website [here](http://www.abandonia.com/en/games/378/Command+%2526+Conquer.html).  It is available free, and the site says that it is _[Freeware](http://en.wikipedia.org/wiki/Freeware)_.  Please be aware that some of the software on the site is termed _[Abandonware](http://en.wikipedia.org/wiki/Abandonware)_, which has disputed legality.  If you want to be sure, just pick software marked as _Freeware_ or _[Shareware](http://en.wikipedia.org/wiki/Shareware)_.

To start, it would be useful to create a subdirectory in `~/dos_c/` called `cnc`.  In it, unzip the file, `Command & Conquer.zip`, that you obtained from the Abandonia website.  Now start DOSBox from your home directory:
{% highlight bash %}$ dosbox{% endhighlight %}

Within the emulation window change to the cnc directory:
{% highlight text %}C:\> cd\cnc{% endhighlight %}

To run the English version (`cnc_de` for German version, `cnc_fr` for French version):
{% highlight text %}C:\CNC> cnc_en{% endhighlight %}

The splash screen should come up, and then present you with a menu:
<img style="clear: right;" width="482" height="300" src="/images/posts/cnc_menu.jpg" title="Command and Conquer Menu" alt="Picture of Command and Conquer Menu"/>

If you click on the emulation window with your mouse, then the emulation window will grab your mouse and you can use it to move the mouse in the DOS window.  `CTRL+F10` will release the mouse.  `ALT+ENTER` will toggle between full screen and normal screen mode.

If you haven't got any sound, try installing the `alsa-oss` module to have the OSS sound system routed to your ALSA sound system.

## Where Now?
Now you can load your old DOS software onto your new machine and remember the good old days.  Alternatively you can download DOS software from a number of websites on the internet for free.  It is worth checking the legality of some of the software before downloading, but there is still plenty of free legal software to download, as well as some to buy.

