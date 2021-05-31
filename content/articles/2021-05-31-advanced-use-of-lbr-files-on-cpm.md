Lots of utilities make use of .LBR (Library) files to provide extra facilities such as the ability to run commands from archives or mount them as if they were drives.  This article shows some more advanced uses of .LBR files and is a follow-up to our previous article: [Working with .LBR files on CP/M](/articles/working-with-lbr-files-on-cpm/).


## Setting Dates

Later versions of the .LBR file format definition added support for dates.  On CP/M these can be set using [SETD v2.2](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/setd22.lbr "SETD22.LBR from Walnut Creek CD: /cpm/utils/arc-lbr/"), dated 1988 by Brent B. Powers.  These dates can be seen using [LDIR-B v2.20](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/enterprs/cpm/utils/f/ldirb22.lbr "LDIRB22.LBR from Walnut Creek CD: /enterprs/cpm/utils/f/") as mentioned in the previous article on .LBR files.  The dates can be supplied at the command line or if you have a real-time clock you can write a small piece of code to query it.

Unusually for 1988 one of the files, SETD22.UPD, contains a warning about what may happen with the dates in the year 2000.  In reality this was more of a problem with the 2 digit years used by SETD and LDIR-B than the .LBR format as the latter uses Digital Research's Julian date format which records the number of days from 31 December 1977 as a 16-bit number.  This would support dates properly up to around the year 2157.

The archive for SETD v2.2 contains an interesting history of its previous versions as listed below:

```
Version 2.0 was the original assembly language version, recoded
from the TurboPascal version, in turn recoded from the
TurboModula-2 version, which was, finally, a translation of C.B.
Falconer's LSETDATE, with a slightly different date-parsing
algorithm.
```

I find it interesting that it went through three languages and in particular at one point was written using [Turbo Modula-2](/2013/03/12/if-only-borland-had-stuck-with-turbo-modula-2-for-cpm/ "TechTinkering article: If Only Borland Had Stuck With Turbo Modula-2 For CP/M"), a language which didn't exist for very long on CP/M.  The Turbo Pascal version is [SETD v0.1](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/setd01.lbr "SETD01.LBR from Walnut Creek CD: /cpm/utils/arc-lbr/"), dated 17 Oct 1987.


## Finding Files Within .LBR Archives

If we have lots of .LBR archives it can be difficult sometimes to remember exactly which archive contains a particular file.  To search these archives we can use [LFIND v1.13](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/jsage/znode3/z3util/lfind.lbr "LFIND.LBR from Walnut Creek CD: /jsage/znode3/z3util/"), dated 8 Nov 1984 by Martin Murray.  LFIND allows us to search all the .LBR files on all drives and for all users to see which contain a matching filespec.  It works really well but only on CP/M 2.2 as on CP/M Plus it lists somes files multiple times.



## Mounting .LBR Archives as a Drive
It is possible to mount a .LBR or a number of .LBR archives as if they were a drive using [LBRDSK v2.3](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/lbrdsk23.lbr "LBRDSK23.LBR from Walnut Creek CD: /cpm/utils/arc-lbr/"), dated 13 Feb 1985 by Jim Lopushinsky.  From here you can read and write to them, although writing isn't ideal because it can clobber files that follow a file if you are altering an existing one.  The LBRDSK archive contains SETRSX11.COM which is used to provide RSX facilities on CP/M 2.2 and for this reasons it will only work on CP/M 2.2.

LBRDSK can be used as follows.  To access LBRDSK23.LBR as if it was drive E: in read/write mode:

```
A> LBRDSK E:=LBRDSK23.LBR
```

To access the members of all the .LBR archives as if they were on drive E: in read mode:

```
A> LBRDSK E:=*.LBR
```


## Running Commands

It is possible to run programs directly from a .LBR archive using [LRUN v2.3](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/lrun23.lbr "LRUN23.LBR from Walnut Creek CD: /cpm/utils/arc-lbr/"), dated 8 Jul 1985 originally by Gary P. Novosielski.  This is very useful if you have lots of small .COM files on a disk as by including them in a .LBR archive you can reduce the amount of space they take up because there may be be less wasted space if they are not a multiple of the block size.  If you don't supply LRUN with a .LBR file then it will default to 'COMMAND.LBR'.  This works very well, however it isn't suitable for all programs as they may need to access other files which can't be contained in the archive.  It should also be noted that the member files can't be compressed.


## Basic Information

Below is some basic information about each utility that you may find useful and interesting.

<table class="neatTable">
  <tr><th>Name</th><th>Version</th><th class="centre">Date</th>
      <th>Size (Kb)</th><th>8080 Compatible</th></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/setd22.lbr" title="SETD22.LBR from Walnut Creek CD: /cpm/utils/arc-lbr/">SETD</a></td><td>2.2</td><td class="right">10 Feb 1988</td><td class="right">3</td><td class="centre">&#10008;</td></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/jsage/znode3/z3util/lfind.lbr" title="LFIND.LBR from Walnut Creek CD: /jsage/znode3/z3util/">LFIND</a></td><td>1.13</td><td class="right">8 Nov 1984</td><td class="right">5</td><td class="centre">&#10008;</td></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/lbrdsk23.lbr" title="LBRDSK23.LBR from Walnut Creek CD: /cpm/utils/arc-lbr/">LBRDSK</a></td><td>2.3</td><td class="right">13 Feb 1985</td><td class="right">8+1</td><td class="centre">&#10004;</td></tr>
  <tr><td><a href="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/arc-lbr/lrun23.lbr" title="LRUN23.LBR from Walnut Creek CD: /cpm/utils/arc-lbr/">LRUN</a></td><td>2.3</td><td class="right">8 Jul 1985</td><td class="right">2</td><td class="centre">&#10004;</td></tr>
</table>

## Video

The following video shows these .LBR utilities in action.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/BK6R4xbOBkU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
