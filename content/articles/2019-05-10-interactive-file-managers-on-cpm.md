CP/M has a number of interactive file managers that can be used to make it easier to handle common file operations rather than using the command line driven commands supplied with CP/M such as: DIR, ERA, PIP, REN, TYPE.

## Early programs

<img src="/img/articles/cpm_wash.png" class="img-right" style="width: 465px; clear: right;" title="WASH v1.5 Menu">

One of the first interactive file management programs was [CLEANUP](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/dirutl/cleanup.com "cleanup.com").  This was a very simple program that just went through each file in a directory and asked you whether you wanted to erase or view each file in turn.

After this came [WASH](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/filcpy/wash15.lbr "wash15.lbr"), by Michael J. Karas of Micro Resources, which states in the accompanying documentation that it was inspired by CLEANUP.  Like CLEANUP, WASH presents each file to the user in turn, but it does this in a circular list and also allows you to go back up the list.  WASH adds some extra functionality as well such as the ability to rename and copy files as well as send files to a printer or punch device.

[SWEEP](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/filcpy/sweep40.lbr "sweep40.lbr"), by Robert Fisher, uses the same basic circular file presentation as WASH.  Its biggest addition is the ability to tag files so that you can mass copy or erase them.  It also supports user areas allowing you to switch to different user areas and copy files back and forth between them.


## NSWEEP

<img src="/img/articles/cpm_nsweep.png" class="img-right" style="width: 465px; clear: right;" title="NSWEEP v2.07 Menu">

Dave Rand created [NSWEEP](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/filcpy/nswp207.lbr "nswp207.lbr") which is very similar to SWEEP, but it is much faster, smaller and generally more polished.  It also adds a few extra features:
  * It can move files from one user area to another, using the rename function, without having to copy and delete
  * It can squeeze and unsqueeze files
  * It displays attributes in file listing by highlighting characters in a filename and allows you to change those attributes

NSWEEP is a great file manager with lots of features and was pretty popular at one time.  However, v2.07 has a bug when used on CP/M Plus while copying
 a file to a disk that isn't ready as it will corrupt the source file and other parts of the source disk.  This is a shame and there was an unofficial v2.08 release which purported to fix this, but [apparently](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/filcpy/nswphint.txt) that introduced some other serious bug.

## B29

<img src="/img/articles/cpm_b29.png" class="img-right" style="width: 465px; clear: right;" title="B29 v3.04 Menu">

In the documentation for [B29](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/lambda/soundpot/a/b29v304.lbr "b29v304.lbr") Gary Conway, its author, states how much he liked NSWEEP but wanted to add a few extra things such as a real-time clock and better printing support.  In the end he decided to write his own version of a SWEEP style program with the extra features that he wanted.  The result is a program very similar to NSWEEP, that in its later versions also added support for .LBR files allowing you to view and extract its members.

B29 is a good alternative to NSWEEP but unfortunately it has a bug when you move a file from one user area to another, where it deletes the file in the source user area but doesn't move it to the new user area.


<br style="clear:right;" />

## DISK7

<img src="/img/articles/cpm_disk7.png" class="img-right" style="width: 465px; clear: right;" title="DISK7.7 Menu">

Frank Gaudé states in the documentation for [DISK7](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/filcpy/disk77b.lbr "disk77b.lbr") that it was based on common ideas presented in CLEANUP, WASH and SWEEP.  This is a much smaller program than B29 or NSWEEP and therefore has less features.  However, it presents a nice clean interface to the user and what it does do it does well.

## VFILER

<img src="/img/articles/cpm_vfiler_dir.png" class="img-right" style="width: 465px; clear: right;" title="VFILER v1.7 Directory View">

[VFILER](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/lambda/soundpot/p/vfiler17.lbr "vfiler17.lbr"), by Richard Conn, follows 'in the footsteps of SWEEP, CLEAN [sic] and DISK' and tries to make it more user friendly by using direct cursor control to create a screen oriented file manipulation utility.  Instead of going from one file to the next as in the other utilities, VFILER presents a screen of file names that you can move between using Wordstar cursor control keys.  It requires a Z80 processor to run and has features similar to DISK7.

<br style="clear:right;" />

## Basic Information

Below is some basic information about each utility that you may find useful.

<table class="neatTable">
  <tr><th>Name</th><th>Size (Kb)</th><th>8080 Compatible</th></tr>
  <tr><td>CLEANUP</td><td>1</td><td>&#10004;</td></tr>
  <tr><td>WASH</td><td>3</td><td>&#10004;</td></tr>
  <tr><td>DISK7</td><td>5</td><td>&#10004;</td></tr>
  <tr><td>VFILER</td><td>8</td><td>&#10008;</td></tr>
  <tr><td>NSWEEP</td><td>12</td><td>&#10004;</td></tr>
  <tr><td>B29</td><td>15</td><td>&#10004;</td></tr>
  <tr><td>SWEEP</td><td>28</td><td>&#10004;</td></tr>
</table>

## Video of the Interactive File Managers

You can see these file managers in action below.

<div class="youtube-wrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/k9XHgh_Mmzw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
