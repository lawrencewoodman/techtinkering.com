Using [Vice](http://vice-emu.sourceforge.net/) to emulate a Commodore 128 running CP/M works very well, but it isn't easy to get CP/M files directly onto and off a _.D64_/_.D71_ disk image.  The easiest way to do this under Linux is to use _ctools_.


## Building ctools

First you need to get the source files for [ctools](https://github.com/mist64/ctools), for this we can use _wget_:
```` bash
$ wget https://github.com/mist64/ctools/archive/master.zip
$ unzip master.zip
````

To build the executables:
```` bash
$ cd ctools-master/src
$ make
$ make install
````

The executable files are now in _ctools-master/bin_.  You will probably find it useful to copy them to somewhere like _~/bin_ to make them easier to access.

## Using ctools

ctools is fairly straightforward to use and most of the time you will only use two of the programs: _cformat_ and _ctools_.

<img src="/img/articles/ctools.png" class="img-right" style="width: 550px; clear: right;" title="ctools">

### Creating a Formatted CP/M Disk Image

_cformat_ allows us to create CP/M disk images and I find it most useful to create double sided C128 disk images using the `-2` switch.

To create a disk image called _work.d71_:
```` bash
$ cformat -2 work.d71
````

<br />

### Working With Files on the Image

Once we have a disk image we can transfer files, erase files, show the directory, etc using the _ctools_ command.

To copy all the _.txt_ files from the current directory onto the disk image, _work.d71_:
```` bash
$ ctools work.d71 p *.txt
````

To display the files on the image:
```` bash
$ ctools work.d71 d
````

To get all the _.txt_ files from the disk image and put them in the current directory:
```` bash
$ ctools work.d71 g "*.txt"
````

## Video of ctools

ctools can be seen being used to transfer files to a .D71 disk image which is then read under an emulated C128 running CP/M on Vice below.

<div class="youtube-wrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/lQ1SS16Y_Pg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
