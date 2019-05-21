[z80pack](http://www.autometer.de/unix4fun/z80pack/) is great for creating an emulated CP/M system.  It can either be used to create a general CP/M system or can emulate a specific system such as an IMSAI or ALTAIR including a graphical front-panel.  It is well documented and is being actively developed.

## Installing z80pack
* First download the source (z80pack-x.y.tgz, currently z80pack-1.36.tgz) for z80pack from [here](http://www.autometer.de/unix4fun/z80pack/ftp/).  The following [installation instructions](http://www.autometer.de/unix4fun/z80pack/#dri_quick "Installation instructions for z80pack") are adapted from those on the z80pack site.  More information can be found there, in particular, information on installing z80pack on non Linux/Unix systems.
* Unpack the source archive in your home directory:
	```` bash
  $ tar xzvf z80pack-1.36.tgz
  ````
* Change the directory it is extracted to, to make this article easier to explain.  There is no need for you to do this.
	```` bash
  $ mv z80pack-1.36 z80pack
  ````
* Compile the emulator for your operating system, e.g. for linux use `-f Makefile.linux`:
   ```` bash
   $ cd ~/z80pack/cpmsim/srcsim
   $ make -f Makefile.operating-system
   $ make -f Makefile.operating-system clean
   ````
* Compile the support programs:
   ```` bash
   $ cd ~/z80pack/cpmsim/srctools
   $ make
   $ make clean
   ````

* If you want to copy the _srctools_ to your _~/bin_ directory then from within _~/z80pack/cpmsim/srctools_ run:
  ```` bash
  $ make install
  ````

This leaves a few bash scripts in the _~/z80pack/cpmsim/_ directory, _cpm2_, _cpm3_, _mpm_, etc, which automatically start the emulator by booting into CP/M 2.2, CP/M 3.0, MP/M, respectively.


## Backup Included Disk Images
z80pack includes a number of disk images in _~/z80pack/cpmsim/disks/library/_.  These can easily get corrupted so it makes sense to backup these first:
```` bash
cd ~/z80pack/cpmsim/disks/library
cp -p * ../backups
````

I also keep my own disk images of useful software in the _library/_ directory and keep a backup in the _backups/_ directory as well.


## Creating disk images
We now needed to create some disk images; to do this I recommend [Cpmtools](http://www.moria.de/~michael/cpmtools/) which is a part of many Linux distros.  If you don't have this as part of your distro, the source can be downloaded from [here](http://www.moria.de/~michael/cpmtools/files/cpmtools-2.20.tar.gz "cpmtools-2.20.tar.gz").  Cpmtools is a great collection of tools used to manipulate CP/M images and file systems in a variety of formats and works well with z80pack.


### Creating Floppy Diskette Images
The emulator uses 8" SD disk drives as the first 4 drives: _A:_, _B:_, _C:_, _D:_.  This disk specification is the default for Cpmtools.  To create a floppy diskette image called, _work.floppy.cpm_, run:
```` bash
$ mkfs.cpm work.floppy.cpm
````

When working with floppies I create a blank floppy called _blank.floppy.cpm_ and then just copy that every time I want to create a new image, rather than creating the image directly.


### Creating Hard Disk Images
z80pack supports a 4Mb hard disk image connected to the _I:_ drive and a 512Mb hard disk image connnected to the _P:_ drive.  These can be particularly useful when dealing with bigger applications such as a C compiler.&nbsp; To create these we can use Cpmtools, but first we need to make sure that it has the correct disk definition by editing _/usr/share/diskdefs_ and adding the following lines, if not already present:

```` text
# 4mb HDD for z80pack
diskdef z80pack-hd
  seclen 128
  tracks 255
  sectrk 128
  blocksize 2048
  maxdir 1024
  skew 0
  boottrk 0
  os 2.2
end

# 512mb HDD for z80pack
diskdef z80pack-hdb
  seclen 128
  tracks 256
  sectrk 16384
  blocksize 16384
  maxdir 8192
  skew 0
  boottrk 0
  os 2.2
end
````


To create a blank 4Mb Hard Disk image called _main.hd4.cpm_, run:
```` bash
$ mkfs.cpm -fz80pack-hd hd4.cpm
````

To create a blank 512Mb Hard Disk image called _main.hd512.cpm_, run:
```` bash
$ mkfs.cpm -fz80pack-hdb hd512.cpm
````


## Managing Files on Disk Images With Cpmtools

Cpmtools comes with a number of commands such as: _cpmls_, _cpmcp_, _cpmrm_.  These allow you to manage files on a disk image and get them on and off.  With all of the commands below if using a 4Mb HDD image add `-fz80pack-hd` and for a 512Mb HDD image add `-fz80pack-hdb` after the Unix command.

CP/M has 16 'user areas' which can be used to organize data on a disk.  They are effectively like a crude directory system. User area 0 is the default and the only one we will work with in this article.

To copy all the _.DOC_ files from the current directory into the image, _work.floppy.cpm_ in user area 0 run:
```` bash
$ cpmcp work.floppy.cpm *.DOC 0:
````

To copy all the _.COM_ files from the current directory into the _hd4.cpm_ image in user area 0 we need to specify the format with `-fz80pack-hd`:
```` bash
$ cpmcp -fz80pack-hd hd4.cpm *.COM 0:
````

To copy all the _.DOC_ files in user area 0, from the _work.floppy.cpm_ image to the current directory:
```` bash
$ cpmcp work.floppy.cpm "0:*.DOC" .
````

To list the files on `work.floppy.cpm`:
```` bash
$ cpmls work.floppy.cpm
````

## Configuring z80pack
In the _~/z80pack/cpmsim/_ directory there are a number of scripts such as _cpm2_, _cpm3_, etc.  These are scripts which tell z80pack which disk images to use for which drives.  We can edit these or create our own.  z80pack expects the disk image files to be in _~/z80pack/cpmsim/disks/_ with the first four 8" floppy disks called _drivea.dsk_ to _drived.dsk_, the 4Mb HDD called _drivei.dsk_ and the 512Mb HDD called _drivep.dsk_.  You don't have to have all these disks, but this is what is available to be used.

As an example we'll create a script called _work_ which uses our 4Mb HDD and floppy disk images created above.  First copy _main.hd4.cpm_ and _work.floppy.cpm_ to the _~z80pack/cpmsim/disks/library/_ directory.  It is also worth copying them to the backups directory as well: _~/z80pack/cpmsim/disks/backups/_

Now create a script in _~/z80pack/cpmsim/_ called _work_ to start z80pack with our disk image files attached:

```` bash
#!/bin/sh
rm -f disks/drive[abci].dsk
cp disks/library/cpm3-1.dsk disks/drivea.dsk
cp disks/library/cpm3-2.dsk disks/driveb.dsk
ln disks/library/work.floppy.cpm disks/drivec.dsk
ln disks/library/main.hd4.cpm disks/drivei.dsk
./cpmsim -f4
````

This attaches the two CP/M disks on drive A and B, our _work.floppy.cpm_ image on drive _C:_, and our _main.hd4.cpm_ image on _I:_.  I copy rather than create links to disk images I know I don't want altered to keep them in a consistent state.  The line `./cpmsim -f4` tells the emulator to run at 4Mhz, which makes it a bit more realistic.

To make the script executable run:
```` bash
$ chmod +x work
````

## Starting the Emulator

<img src="/img/articles/z80pack_boot_cpm3.png" class="img-right" style="width: 465px; clear: right;" title="z80pack booting CP/M 3">

From the `~/z80pack/cpmsim/` directory, run the script we created:
````bash
$ ./work
````

The CP/M operating system will now boot up and leave you at the `A>` prompt.  You will have access to the _A:_ and _B:_ diskette images which will contain the CP/M 3 files.  _C:_ will be linked to your _work.floppy.cpm_ disk image and _I:_ will be linked to your 4Mb HDD image.

For here you can run the normal CP/M commands such as _DIR_ and start exploring.

There is a command on the _A:_ drive called _bye_ to leave the emulator:
```` text
A> bye
````


## Where Now?

I have a growing number of [CP/M articles](/articles/tag/cpm/) on this site and there is also a [CP/M Playlist](https://www.youtube.com/playlist?list=PL6PrE7UVkn_NEGOhOca8_3MP1zUSYDGwc) on the [TechTinkering YouTube Channel](https://www.youtube.com/user/TechTinkering).
