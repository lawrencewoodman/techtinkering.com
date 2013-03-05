---
layout: article
title: "Setting up z80pack to Create an Emulated CP/M System"
summaryPic: small_z80pack_cpm3.png
summaryPicTitle: "Loading Screen for CP/M 3.0 on z80pack"
tags:
  - CP/M
  - Emulation
  - Retro
  - Z80
  - Tutorial
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
edited: 2013-03-05
licence: cc_attrib
---
I have decided to try out some old CP/M software, but need something to run it on.&nbsp; I could either do this on my Commodore 128 or through emulation.&nbsp; Unfortunately the 1571 disk drive for my Commodore is currently out of action, so that leaves me with emulation.&nbsp; I was going to use [vice](http://www.viceteam.org/) to emulate a C128, but have always found it a pain to get CP/M files onto .D64/71 disk images.&nbsp; After looking around for the best emulator to run CP/M on, I came up with either [YAZE-AG](http://www.mathematik.uni-ulm.de/users/ag/yaze-ag/) or [z80pack](http://www.autometer.de/unix4fun/z80pack/).  z80pack seems to be better supported, has more documentation and is being actively developed, so that&#039;s the one I have chosen for this article.

## Installing z80pack
* First download the source (z80pack-x.y.tgz, currently z80pack-1.17.tgz) for [z80 pack](http://www.autometer.de/unix4fun/z80pack/ "A mirror of Udo Munk's old site") from [here](http://www.autometer.de/unix4fun/z80pack/ftp/).  The following [installation instructions](http://www.autometer.de/unix4fun/z80pack/#dri_quick "Installation instructions for z80pack") are taken from the z80pack site.  More information can be found there, in particular, information on installing z80pack on non Linux/Unix systems.
* Unpack the source archive in your home directory:
	{% highlight bash %}$ tar xzvf z80pack-x.y.tgz{% endhighlight %}
* Change the directory it is extracted to, to make this article easier to explain.  There is no need for you to do this.
	{% highlight bash %}$ mv z80pack-1.16 z80pack{% endhighlight %}
* Compile the emulator:
   {% highlight bash %}
   $ cd ~/z80pack/cpmsim/srcsim
   $ make
   $ make clean{% endhighlight %}
* Compile the support programs:
   {% highlight bash %}
   $ cd ~/z80pack/cpmsim/srctools
   $ make
   $ make clean{% endhighlight %}

This is leaves, on Linux, a few bash scripts in the `~/z80pack/cpmsim/` directory, `cpm2`, `cpm3`, `mpm`, which automatically start the emulator by booting into CP/M 2.2, CP/M 3.0, MP/M, etc.

## Creating disk images
We now needed to create some disk images; to do this I recommend [Cpmtools](http://www.moria.de/~michael/cpmtools/) which is a part of many Linux distros.  If you don't have this as part of your distro, the source can be downloaded from [here](http://www.moria.de/~michael/cpmtools/cpmtools-2.7.tar.gz).  Cpmtools is a great collection of tools used to manipulate CP/M images and file systems in a variety of formats and works well with z80pack.

### Create a 4Mb Hard Disk Image
It would be useful to create a 4Mb Hard Disk Image, as this may be needed if we want to use any bigger applications such as a C compiler.&nbsp; To create this we can use Cpmtools, but first we need to make sure that it has the correct disk definition by editing `/etc/cpmtools/diskdefs` and adding the following lines:

{% highlight text %}
# 4mb HDD for z80pack
diskdef hd
  seclen 128
  tracks 255
  sectrk 128
  blocksize 2048
  maxdir 1024
  skew 0
  boottrk 0
  os 3.0
end
{% endhighlight %}

CP/M has 16 'user areas' which can be used to organize data on a disk.  They are effectively like a crude directory system. User area 0 is the default and the only one we will work with in this article.

To create a blank 4Mb Hard Disk image called `main.hd4.cpm`, run:
{% highlight bash %}
$ mkfs.cpm -fhd main.hd4.cpm
{% endhighlight %}

Then to copy all the `.COM` files from the current directory into the image in user area 0, run:
{% highlight bash %}
$ cpmcp -fhd hd4.cpm *.COM 0:
{% endhighlight %}

### Create a Floppy Diskette Image
To create a floppy diskette image called, `work.dsk.cpm`, run:
{% highlight bash %}
$ mkfs.cpm work.dsk.cpm
{% endhighlight %}

Then to copy all the `.DOC` files from the current directory into the image in user area 0: run:
{% highlight bash %}$ cpmcp work.dsk.cpm *.DOC 0:{% endhighlight %}


## Configuring z80pack
We now have a 4mb disk image and a floppy disk image.  We can connect them to the emulator by creating a script in the `~/z80pack/cpmsim/` directory called `work`.  First copy `main.hd4.cpm` and `work.dsk.cpm` to the `~z80pack/cpmsim/disks/library/` directory.  It is also worth copying them to the backups directory as well: `~/z80pack/cpmsim/disks/backups/`

Now create a script in `~/z80pack/cpmsim/` called `work` to start z80pack with our disk image files attached:

{% highlight ruby %}
#!/bin/sh
rm -f disks/drive[abci].cpm
ln disks/library/cpm3-1.dsk disks/drivea.cpm
ln disks/library/cpm3-2.dsk disks/driveb.cpm
ln disks/library/work.dsk.cpm disks/drivec.cpm
ln disks/library/main.hd4.cpm disks/drivei.cpm
./cpmsim -f4
{% endhighlight %}
This attaches the two CP/M disks on drive A and B, our `work.dsk.cpm` image on drive C, and our `main.hd4.cpm` image on I:
The line `./cpmsim -f4` tells the emulator to run at 4Mhz, which makes it a bit more realistic.

## Starting the emulator
From the `~/z80pack/cpmsim/` directory, run the script we created:
{% highlight bash %}$ ./work{% endhighlight %}

The CP/M operating system will now boot up and leave you at the `A>` prompt.

To leave the emulator type:
{% highlight text %}A> a:bye{% endhighlight %}
