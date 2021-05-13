The .LBR (Library) file format was the most common form of multi-file archive on personal computers at one time.  It was created by Gary P. Novosielski in 1982 for use by his LU (Library Utility) program and the author mentions benefits such as making it easier to download and distribute related files on RCPM systems as well as making better use of disk space and directory structure.  .LBR reigned supreme until it was displaced by the .ARC/.ARK file format on MS-DOS and later CP/M which combined compressing member files with including them in an archive in a single process.  If we look on the [Walnut Creek CD](http://cpmarchives.classiccmp.org/ftp.php?b=cpm/Software/WalnutCD/) we will see that the majority of multi-file archives are .LBR files.


An archive consists of a number of directory entries and member files arranged sequentially into a single archive.  The format does not directly support compression but member files were often [compressed](/articles/compression-and-archiving-on-cpm/) with Squeeze, Crunch, etc prior to being included in an archive.  These member files are easily accessed and therefore utilities were written to view and extract individual files.  On RCPM systems this allowed remote users to investigate what they may download prior to doing so.  LMODEM was particularly useful as it allows you to download a single member file from an archive which could be important if downloading the whole archive would exceed the system time limit for a user.


This article contains a selection of useful utilities for handling .LBR archives and at the end is a [table showing their versions, release dates, .COM files sizes and 8080 compatibility](#article-basic-information).


## .LBR File Format Definition

The earliest definition of the file format I can find is [LUDEF1.DOC](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/simtel/sigm/vols100/vol119/ludef1.doc "LUDEF1.DOC from Walnut Creek CD: /simtel/sigm/vols100/vol119/").  This is dated 4 November 1982 and refers to the original LUDEF.DOC dated 31 October 1982.  Two particularly notable things about the format are:
1. The member files have to be included using whole 128-byte sectors and hence file size was measured by the number of 128-byte sectors.
2. Thankfully Gary had the foresight to reserve 16 bytes per entry for future use.  This was particularly important because it later allowed better interoperability with UNIX, MS-DOS, etc where files weren't made up of 128-byte sector files and hence a number of 'pad' bytes could be specified.

The last revision of the document is [LUDEF5.DOC](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/ludef5.doc "LUDEF5.DOC from Walnut Creek CD: /cpm/utils/arc-lbr/") dated 19 August 1984, which allowed the addition of dates and CRC values.


## LU

As mentioned above .LBR files began as the format for LU.  This utility allows you to create a .LBR archive and to add, list, delete, extract, etc its member files.  As with all of Gary's .LBR related programs it was written in BDS C which meant that they were relatively big compared to other later programs written in assembly language by other people.  However, this did allow the use of BDS C "pipes".  The earliest version of LU I have found is [LU v1.10](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/lambda/soundpot/f/lu101.lbr "LU101.LBR from Walnut Creek CD: /lambda/soundpot/f/"), dated 4 August 1982 and the latest version is [LU v3.10](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/jsage/zsus/lbr/lu310.lbr "LU310.LBR from Walnut Creek CD: /jsage/zsus/lbr/"), dated 1 January 1985.  The later version is naturally more advanced and has built-in help but doesn't fully support the dates as defined by LUDEF5.DOC.

LU could be used interactively or from the command line.   If called from the command line it would like like this:
```
A> LU -O LU101.LBR -L -E LU.DZC
```

The arguments mean the following
* `-O LU101.LBR` Open a library called LU101.LBR
* `-L` List its members
* `-E LU.DZC` Extract a member file called LU.DZC

The documentation for LU is worth looking at because it contains some interesting discussion about why to use .LBR libraries and why not to use them.


## LSWEEP

LSWEEP can extract and view member files of a .LBR archive by allowing you to cycle through each file in a circular list similar to that used by SWEEP.  The program can use multiple .LBR archives at once either by specifying them individually or using wildcards on the command line.  It was created by Joe Vogler and [LSWEEP v1.03](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/lsweep13.com "LSWEEP13.COM from Walnut Creek CD: /cpm/utils/arc-lbr/") ([DOC](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/lsweep13.doc "LSWEEP13.DOC from Walnut Creek CD: /cpm/utils/arc-lbr/")) was released in 1984.  One particularly handy feature is that it will automatically unsqueeze members when extracting or viewing files.

## NULU

NULU builds on LU by adding more options to manipulate libraries as well as to be able to view and unsqueeze the member files.  In addition it has a file sweep mode similar to LSWEEP.  NULU does all this in a program which is no bigger than either LU or LSWEEP on their own.  It was originally written by Martin Murray but the latest version, [NULU v1.52a](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/nulu152a.lbr "NULU152A.LBR from Walnut Creek CD: /cpm/utils/arc-lbr/") is an unofficial release in 1987 by Mick Waters to fix bugs in the previous release.

## EXTRACT

EXTRACT is the smallest library extraction program I have come across.  It is only 4Kb and it can even unsqueeze member files.  It was written by Gil Shultz and [EXTRACT v1.1d](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/extract.lbr "EXTRACT.LBR from Walnut Creek CD: /cpm/utils/arc-lbr/") was released in 1986.  EXTRACT has a great command line interface that allows you to easily handle extracting files from libraries to different drives and users.  It is mentioned much less than [DELBR v1.2](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/delbr12.ark "DELBR12.ARK from Walnut Creek CD: /cpm/utils/arc-lbr/") with which it competes but DELBR is 13Kb compared to EXTRACT's 4Kb and can't unsqueeze members.


## LT

LT (Library Typer) can extract and view files in a .LBR archive.  It is only 7Kb and not only can it handle member files that are compressed with Squeeze and Crunch but it can also handle LHA compressed files.  The program was originally written by C.B Falconer and [LT v31](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/beehive/compress/lt31.lbr "LT31.LBR from Walnut Creek CD: /beehive/compress/") was released in 1991.



## LDIR

LDIR was originally written to provide RCPM Systems with an easy and secure way to allow users to list members of .LBR archives and to see their sizes.  I include [LDIR v2.11](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/simtel/sigm/vols100/vol152/ldir211.lbr "LDIR211.LBR from Walnut Creek CD: /simtel/sigm/vols100/vol152/") of Gary P. Novosielski's LDIR program here, dated 21 March 1983, mainly because it contains an interesting mention of discussions about whether whole .LBR archives should be compressed or their individual members.  He comes down on the side of individual members and this proves to be the majority opinion as can be seen from the files on the Walnut Creek CD where the vast majority of .LBR files have their individual member files compressed rather than the whole archive (.LQR or .LZR).  I have included most of the relevant file below:

```
File:   LDIR.MSG                Date: 82-11-14
To:     All Remote System Operators
From:   Gary P. Novosielski     CIS[70160,120]
Subj:   Library Directory program

There have been several requests from RCPM and other remote
system operators for a utility to allow callers to see the
directory of .LBR files available on the system.  LDIR is
such a program.

LDIR performs no other function besides displaying the
directory of .LBR files, and can be made available to
callers as a .COM file.  While the LU library utility can
also perform this function, it would be sucide to leave this
out in a useable form, since it could be used to introduce
any arbitrary .COM file onto the system.

There has been a difference of opinion on whether .LBR's should
be squeezed before transmission, or whether the indivudual
members should be squeezed before being added to the .LBR.
There are good arguments for both sides, but since squeezing
an entire library would render the directory unreadable, I
suggest taking the latter alternative, and leaving the library
as an unsqueezed .LBR rather than a .LQR file.

Experimentation has shown that on many libraries, there will
be a slight cost in library size by opting for thia method,
but the visibility of the directory would seem to outweigh this
objection.  Of course any or all members of the unsqueezed
library can still be squeezed files, so there is still a large
saving over normal ASCII encoded files.  The savings in time
and disk space which are inherent in the use of .LBR files also
helps to mitigate the slight size increase.
```


## LDIR-B

LDIR programs continued to be useful and [LDIR-B v2.20](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/enterprs/cpm/utils/f/ldirb22.lbr "LDIRB22.LBR from Walnut Creek CD: /enterprs/cpm/utils/f/") was originally written by Steven Greenberg and released in 1991.  It displays further information such as the created and modified dates, the compression method and original filename of squeezed or crunched files.  The programs is only 2Kb but unfortunately requires a Z80.


## SD
SD (Super Directory) is a great DIR alternative which includes the ability to list the member files of .LBR archives along with .ARC files.  [SD v1.38b](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/enterprs/cpm/utils/s/sd138b.lbr "SD138B.LBR from Walnut Creek CD: /enterprs/cpm/utils/s/") was released in 1989 and a previous article, [DIR Alternatives on CP/M](/articles/dir-alternatives-on-cpm/), goes into more detail about this program.  Other than [QL](#article-ql) this is the program I use most often for listing the members of .LBR archives as it is only 6Kb and can do so much more besides.  As an example of its power the following command displays the members of all .LBR files for all users on all drives:

```
A> SD *.LBR $LEAD
```
This uses the wildcard `*.LBR` to list all .LBR files and the `$LEAD` options mean the following
* `$L` List members of archives
* `$E` List only member files
* `$A` Look under all users
* `$D` Look on all drives


<h2 id="article-ql">QL</h2>

QL is one of my favourite programs on CP/M.  It has a well-thought-out interface and makes it a joy to quickly list files in a directory or .LBR archive and select one by number to view it.  QL will automatically unsqueeze or uncrunch files when viewing and can even extract files to disk. [QL v4.1](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/txtutl/ql41.lbr "QL41.LBR from Walnut Creek CD: /cpm/utils/txtutl/") was released in 1989 and is only 10Kb.  Compared to the other programs mentioned in this article it is the only one where you can easily move forward and backward through a viewed file as well as search within it.  QL is only 10Kb but unfortunately requires a Z80.  It features in a previous article, [Text Viewers on CP/M](/articles/text-viewers-on-cpm/).


<h2 id="article-basic-information">Basic Information</h2>

Below is some basic information about each utility that you may find useful and interesting.

<table class="neatTable">
  <tr><th>Name</th><th>Version</th><th class="centre">Date</th>
      <th>Size (Kb)</th><th>8080 Compatible</th></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/lambda/soundpot/f/lu101.lbr" title="LU101.LBR from Walnut Creek CD: /lambda/soundpot/f/">LU</a></td><td>1.10</td><td class="right">4 Aug 1982</td><td class="right">18</td><td class="centre">&#10004;</td></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/jsage/zsus/lbr/lu310.lbr" title="LU310.LBR from Walnut Creek CD: /jsage/zsus/lbr/">LU</a></td><td>3.10</td><td class="right">1 Jan 1985</td><td class="right">20</td><td class="centre">&#10004;</td></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/lsweep13.com" title="LSWEEP13.COM from Walnut Creek CD: /cpm/utils/arc-lbr/">LSWEEP</a> (<a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/lsweep13.doc" title="LSWEEP13.DOC from Walnut Creek CD: /cpm/utils/arc-lbr/">DOC</a>)</td><td>1.03</td><td class="right">22 Jan 1984</td><td class="right">16</td><td class="centre">&#10004;</td></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/nulu152a.lbr" title="NULU152A.LBR from Walnut Creek CD: /cpm/utils/arc-lbr/">NULU</a></td><td>1.52a</td><td class="right">7 Dec 1987</td><td class="right">16</td><td class="centre">&#10004;</td></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/extract.lbr" title="EXTRACT.LBR from Walnut Creek CD: /cpm/utils/arc-lbr/">EXTRACT</a></td><td>1.1d</td><td class="right">24 Jan 1986</td><td class="right">4</td><td class="centre">&#10004;</td></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/delbr12.ark" title="DELBR12.ARK from Walnut Creek CD: /cpm/utils/arc-lbr/">DELBR</a></td><td>1.2</td><td class="right">24 Nov 1989</td><td class="right">13</td><td class="centre">&#10004;</td></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/beehive/compress/lt31.lbr" title="LT31.LBR from Walnut Creek CD: /beehive/compress/">LT</a></td><td>31</td><td class="right">15 Dec 1991</td><td class="right">7</td><td class="centre">&#10004;</td></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/simtel/sigm/vols100/vol152/ldir211.lbr" title="LDIR211.LBR from Walnut Creek CD: /simtel/sigm/vols100/vol152/">LDIR</a></td><td>2.11</td><td class="right">21 Mar 1983</td><td class="right">7</td><td class="centre">&#10004;</td></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/enterprs/cpm/utils/f/ldirb22.lbr" title="LDIRB22.LBR from Walnut Creek CD: /enterprs/cpm/utils/f/">LDIR-B</a></td><td>2.20</td><td class="right">10 Sep 1991</td><td class="right">2</td><td class="centre">&#10008;</td></tr>
  <tr><td><a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/enterprs/cpm/utils/s/sd138b.lbr" title="SD138B.LBR from Walnut Creek CD: /enterprs/cpm/utils/s/">SD</a></td><td>1.38b</td><td class="right">20 Aug 1989</td><td class="right">6</td><td class="centre">&#10004;</td></tr>
  <tr><td><a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/txtutl/ql41.lbr" title="QL41.LBR from Walnut Creek CD: /cpm/utils/txtutl/">QL</a></td><td>4.10</td><td class="right">26 Jan 1989</td><td class="right">10</td><td class="centre">&#10008;</td></tr>
</table>


## Video

The following video shows the various .LBR utilities in action.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/OD36mwGNn2c" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
