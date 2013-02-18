---
layout: article
title: "Installing ZDE 1.6, a programmers editor for CP/M"
summaryPic: small_zde16_screenshort.png
summaryPicTitle: "ZDE 1.6 viewing ZDE10.DOC and showing help menu"
tags:
  - CP/M
  - Editors
  - Programming
  - Retro
  - Tutorial
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
To do any serious programming under CP/M, the first thing you need is a good programmers editor.  There aren't many in the archives, but I have tried most of them and found ZDE to be the best.  It is small, has lots of features, and uses Wordstar commands which are familiar to me and easy to learn.

## Downloading files for ZDE
The ZDE 1.6 editor can be downloaded from Bo Zimmerman's CP/M archive [here](http://zimmers.net/anonftp/pub/cpm/editors/zde16.pma).  This file is in a `.PMA` archive, so we also need the utility, [pmautoae.com](http://zimmers.net/anonftp/pub/cpm/archivers/pmautoae.com), to uncompress it, again from Bo Zimmerman's site.  These two files should be copied onto a floppy disk or disk image if using an emulator.

## Unpacking ZDE
I am currently using an emulator which only has 8" SD disks which are not big enough to unpack ZDE onto and contain the compressed file.  Therefore I will have the files `pmautoae.com` and `zde16.pma` on a disk in my C: drive and will uncompress them to a blank disk in my B: drive.

`pmautoae.com` is a self-expanding archive so to expand it onto my B: drive from the archive on my C: drive, I run:
{% highlight text %}B> c:pmautoae{% endhighlight %}

Then to extract the contents of the `zde16.pma` archive held on my C: drive to the B: drive, I run:
{% highlight text %}B> pmext c:zde16.pma b:{% endhighlight %}

If your disks are big enough, then you can do the above all on one disk, say the B: drive; in which case do the above, but change references to `c:` to `b:`

## Configuring ZDE
Before the editor can be used, it needs to be configured.  The most important thing to configure is the Terminal type, which is done as follows:
{% highlight text %}B> zdenst16 zde16{% endhighlight %}

Select `t` to configure the terminal, then `l` to list the terminals.  Press return until your terminal is shown, then press `y` next to it.  I am using [z80pack](http://www.unix4fun.org/z80pack/) so therefore choose `ANSI standard`.  Now press `ESC` then `s` to save the changes.  If you are unsure which terminal to select, try each in turn, then start ZDE to see if it works, pressing `ESC q` to quit.


ZDE should be ready to go at this point.  To read the ZDE documentation, type the following:
{% highlight text %}B> zde16 zde10.doc{% endhighlight %}

### Using ZDE
The editor is started with the command `zde16` and can be run with a filename as an argument.  If a filename is supplied, the editor will try to open it, if it doesn't exist then it will start a new file with the name supplied.
ZDE uses the Wordstar key combinations which are explained in the ZDE documentation.  On some machines the main command key `CTRL+k` is used as a cursor key, in which case `ESC` can be used instead.  The most important commands are listed below:

<table class="neatTable">
<tr><th>Command</th><th>Purpose</th></tr>
<tr><td>ESC h</td><td>Bring up the command key help</td></tr>
<tr><td>CTRL+k q / ESC q</td><td>Quit editor without saving</td></tr>
<tr><td>CTRL+k x / ESC x</td><td>Exist and Save</td></tr>
<tr><td>CTRL+k l / ESC l</td><td>Load a new file</td></tr>
<tr><td>CTRL+k s / ESC s</td><td>Save the current file</td></tr>
<tr><td>CTRL+r</td><td>Page up</td></tr>
<tr><td>CTRL+c</td><td>Page down</td></tr>
<tr><td>CTRL+e / cursor</td><td>Line up</td></tr>
<tr><td>CTRL+x / cursor</td><td>Line down</td></tr>
<tr><td>CTRL+s / cursor</td><td>Cursor left</td></tr>
<tr><td>CTRL+d / cursor</td><td>Cursor right</td></tr>
</table>


ZDE is a great editor and well worth the time to learn.  It has many facilities to make life easier for the programmer and will definitely help make your retro programming more productive.
