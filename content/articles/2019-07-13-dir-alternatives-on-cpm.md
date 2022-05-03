There are lots of great alternatives to the standard CP/M DIR command, which add extra functionality and combine features that normally have to be accessed through other CP/M commands such as STAT or SHOW.   In this article I want to show a few of the best DIR replacements, which provide a better display with more facilities in a smaller sized executable.  I will also discuss a couple of others which do something a little different.


## CP/M Standard Commands

Although CP/M comes with a number of standard commands to list files in a directory as well as check file sizes, attributes and disk space they are a bit pedestrian and especially in the case of CP/M 3 are quite large on the disk.

### CP/M 2.2

<img src="/img/articles/cpm22_dir_stat.png" class="img-right" style="width: 350px; clear: right;" title="CP/M 2.2 DIR and STAT for h*.*">

CP/M 2.2 provides two commands useful for listing files:
* DIR - which can only list filenames
* STAT - which can show file sizes in k and records as well as show free space on a disk.  The STAT executable is 5k.

Both of these commands are limited to only being able to display files for the current user area.

### CP/M 3

<img src="/img/articles/cpm3_dir_alldrives_allusers.png" class="img-right" style="width: 600px; clear: right;" title="CP/M 3 DIR listing h*.* for all users on all drives">

CP/M 3 extends the built-in DIR command by adding DIRS to list files with the system attribute and by adding the DIR command on disk which provides additional features such as:
* Display file sizes in k or records
* Display attributes
* Search in any or all user areas
* Search on all disks
* Sort filenames alphabetical order, although they are sorted horizontally which I find harder to read than when a file list is sorted vertically.

CP/M 3 also provides the SHOW command which can display extra information such as:
* Free space on a disk
* Number of free directory entries
* Number of files for each user number
* Drive characteristics

These commands work well and provide a nicely formatted display.  However, they are big:
* DIR is 15k
* SHOW is 9k

Whereas the biggest DIR replacement below is only 6k.

## DIR Alternatives

Due to the limitations of the CP/M 2.2 DIR/STAT commands a number of replacements were created and then later extended to support CP/M 3 and other compatible systems.
Each of the DIR replacements below has different pros and cons, although they all have the following in common:
* Show file sizes for each file in k
* Show the number of files and how much disk space they use in total
* Show the amount of free disk space
* Filenames are sorted in alphabetical order
* Support CP/M 2.2 and CP/M 3
* Available on the [Walnut Creek CD](http://www.classiccmp.org/cpmarchives/ftp.php?b=cpm/Software/WalnutCD)

### DA
[DA](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/dirutl/da22.lbr "DA22.LBR") is the smallest at 2k and is called DA because it stands for _Directory Attributes_ as this program puts more focus on handling attributes so that you can views files with/without specific attributes such as the _System_, _Read-Only_ or _Archive_ attributes; change those attributes as well as list them clearly without having to rely on terminal codes to highlight characters in the filename.


<img src="/img/articles/cpm_da22.png" class="img-right" style="width: 600px; clear: right;" title="DA v2.2 showing attributes and also showing files with and without system attribute">

DA is also interesting because it shows the actual size of files rather than just rounded to the block size of the disk, in addition it can show the size of files in records.

By default it lists files sorted horizontally, but can easily be configured to sort vertically by changing a byte in the file.  You can also configure it to display different numbers of columns per line, which can be useful for those using screens which have something other than 80 columns.

I like DA a lot as it has a clear compact display, the command line options are very easy to use, it can directly list from other user areas using something like `B1:`, and it is only 2k.  However, it isn't 8080 compatible and it's a shame it doesn't come with source code.  It also has some limitations as it can only cope with up to 255 files, 999k file sizes, and 8190k free space, although this shouldn't cause a problem for the vast majority of systems.

The version linked to is v2.2 by Eric Meyer and is dated January 1987.

### DIRR
[DIRR](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/dirutl/dirr5.lbr "DIRR5.LBR") is a little bit quicker than DA and still relatively small at 5k.  It lists the files in a directory sorted vertically as standard and can list the attributes for each file as well as be configured to allow highlighting of a character in the filename to represent the attributes for a file.

<img src="/img/articles/cpm_dirr5.png" class="img-right" style="width: 600px; clear: right;" title="DIRR v5 listing files in current user area and for all user areas">

Although it doesn't have the same control of attributes that DA has, it can include the display of files with the _System_ attribute.  The main functionality that DIRR adds is the ability to show files for all user areas on the disk being used as well as send the output to a file or printer.

Overall DIRR is another good DIR replacement with a nice clear display and some useful extra functionality.  I particularly like the fact that the source code is included and that it is compatible with the 8080.  Users of systems with something other than 80 columns may be pleased to hear that you can configure how many columns to display per line.

The history of this program is unclear, but Irv Hoff who released v5, dated 7th January 1986, has tried to explain its origins in the documentation which makes for quite interesting reading.  It seems to have started as a C program that was then disassembled and enhanced by James R. King in 1983.  Irv took this source code, translated it from Z80 to 8080 assembly and then continued to enhance it.

### SD
[SD](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/enterprs/cpm/utils/s/sd138b.lbr "SD138B.LBR") is called _Super Directory_ for good reason, it's fast, full of features and yet still only 6k.  It can do pretty much everything that DIRR can do, although it can't list the attributes separately for each file.  However, it can still highlight letters in a filename or change letters to lowercase to represent attributes.  Like DIRR, SD sorts files vertically by default although it can be configured to sort horizontally and this can be switched at run-time.

<img src="/img/articles/cpm_sd_adsl.png" class="img-right" style="width: 600px; clear: right;" title="SD v138b listing d*.* for all users on all drives including system files and listing the contents of any .LBR files">

While SD doesn't have the control over attributes that DA has, it can list _System_ files and files not yet _Archived_.  When logging the directory to a file I like that it appends to an existing file rather than replace it each time, this can be used to create a searchable index.  I also like that you can sort files by type.

The biggest different between SD and the other programs is that it can list members of LBR/ARC/ARK files so that if you wanted to list all files on all drives for all users including members of LBR/ARC/ARK files and log it to a file you could run something like the following:

    A> SD $ADLF

Because of the `$A` (all users) and `$D` (all drives) options, SD can work as a file finder so that if you wanted to find all '.A?M' files for all users on all disks you could run:

    A> SD *.A?M $AD

<br />

SD provides, for me, the nicest display with a configurable highlighted title showing the number files and k free/used.  The program is compatible with the 8080 and is highly configurable through the included source code which allows you to configure the display output, which drives (defaults to A: and B:) and how many user areas can be viewed (defaults to 16), etc.  As you may expect, it can also list directories for other users directly using something like `B1:` in the same way that DA can.  Some people may also be interested that it provides lots of extra support for Z80DOS and ZCPR3 as well as having configurable options useful to RCP/M systems.

From comparing [SD-22.ASM](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/dirutl/sd-22.asm "SD-22.ASM") with SD138B.ASM using [meld](https://meldmerge.org/) on Linux, it seems to have originally have been written by Bruce R. Ratoff.  The earliest revision mentioned in the SD-22.ASM source code is 22 November 1980 and below that it says that the program is based on 'DIRS' by Keith Petersen, W8SDZ.  The program linked to above is v138B, released by Ken Reid, 20 August 1989.

### Video: How to Configure Super Directory

The following video shows how to configure SD for a terminal and how to extend the number of drives and users that SD can access.

<div class="youtube-wrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/9UD271LLFL8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## Something Different

The programs above are all good replacements/companions for the built-in DIR and associated commands.  However, there are other programs that take a different approach.

### D / WHATSNEW


If you wanted to provide a way of checking what has changed in a directory you can use [D / WHATSNEW](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/dirutl/d-31.asm "D-31.ASM").  It works by running the program on a directory using its `SET` option which creates a new file called 'D.COM', which when run will tell you what is new and what has been removed.  The newly created file 'D.COM' is often renamed to something like 'WHATSNEW.COM' to make its function clearer.

<img src="/img/articles/cpm_d_whatsnew.png" class="img-right" style="width: 500px; clear: right;" title="D v3.1 showing changes to directory">

D is only 3k, although the file it creates becomes bigger the more files it records.  It can be a useful utility, especially when using hard disks to keep track of lots of files which also makes it useful for RCP/M systems to show users what's new.  One particularly interesting feature is that it has an option to create a '.SUB' file which could then be used to backup any new files.

According to the source code it was originally created by Ward Christensen (23 November 1978) and if you are interested, [D-29.ASM](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/dirutl/d-29.asm) has a more complete revision history.  The program comes as 8080 source code only, so you have to assemble it yourself.  The version linked to above is v3.1 and was released by Irv Hoff, 5th May 1984.


### ZX

I mention [ZX](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/sysutl/zx31.lbr "ZX31.LBR") not because I recommend it, but because it does something quite interesting in that it tries to add simple commands such as rename, copy, erase, unerase, view, print, etc into only 3k.  It's reporting of disk space used/free seems to be off on bigger disks when used with CP/M 2.2 and they are completely wrong when used with CP/M 3.  It can also only work in the current user area.  However, if you ignore these problems, ZX can be quite a useful utility for space constrained systems.

<img src="/img/articles/cpm_zx_copy_erase.png" class="img-right" style="width: 600px; clear: right;" title="ZX v3.1 listing a directory and then copying and erasing files">

One particularly notable feature is that it will remember the last two files that it performed operations on.  So that if for example you copy all the '.ASM' files from A: to B: by running:

    A> ZX *.ASM B: C

You could then erase them with the following, where `1` refers to '*.ASM':

    A> ZX 1 E

After most operations it will bring up the directory again to show you the changes.

ZX doesn't come with source code and only works on machines with a Z80.  It was written by Mike Yarus and the earliest release I have found for it was August 1985.  The version linked to above is v3.1, from 1986.

## Video of the DIR Alternatives

You can see these DIR Alternatives in action below.

<div class="youtube-wrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/PRm6BSo722c" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
