CP/M has the ability to handle lots of different compression and archive formats which was important due to the limited capacity of floppy disks and the cost of downloading/uploading files on BBS's.  They each have their pros and cons and this article will explore some of the most common ones and where you can find programs on the [Walnut Creek CD](http://www.classiccmp.org/cpmarchives/ftp.php?b=cpm/Software/WalnutCD) to handle them.


## Compression Only
The first compression formats on CP/M only compressed single files and would change the middle letter of the file extension to signify that the file had been compressed.

<dl>
  <dt>.?Q?</dt>
  <dd>Squeeze was an early compression format that used Huffman encoding to compress files.  These can be <em>squeezed</em> (compressed) with <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/startkit/sq111.com" title="sq111.com">sq</a> and <em>unsqueezed</em> (decompressed) with <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/startkit/usq120.com" title="usq120.com">usq</a>.</dd>

  <dt>.?Z?</dt>
  <dd>Crunch brought LZW compression to CP/M and these files can be handled with <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/beehive/compress/crunch28.arc" title="crunch28.arc">crunch</a>.</dd>

  <dt>.?Y?</dt>
  <dd>These files, using LHA compression, were relatively uncommon.  They can be handled with <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/beehive/compress/crlzh20.lbr" title="crlzh20.lbr">crlzh</a> or my favourite for just decompressing is <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/beehive/compress/crunch28.arc" title="crunch28.arc">uncr</a>.</dd>
</dl>

## Archive Only
<dl>
  <dt>.LBR</dt>
  <dd>LBR was an early CP/M format that allowed you to combine multiple files into a single archive.  These files would often have been compressed with tools such as squeeze or crunch.  Because it was so common it was well supported by other tools such as QL, LRUN, LSWEEP and others which can look into a .LBR archive and use individual files without having to separately extract first.  These files can be handled using <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/utils/arc-lbr/nulu152a.lbr" title="nulu152a.lbr">nulu</a> or if you just want to extract files, <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/beehive/compress/delbr.com" title="delbr.com">delbr</a>.  For more information have a look at our article: <a href="/articles/working-with-lbr-files-on-cpm/">Working with .LBR on CP/M</a>.</dd>
</dl>

## Multiple File Archives with Compression
Later on CP/M adopted formats from other platforms, such as MS-DOS, which integrated file compression and archiving into a single format.

## Compress and Decompress
<dl>
  <dt>.ARC/.ARK</dt>
  <dd>This is the most common compressed archive format on CP/M.  Internally it analyses each file which it is asked to compress and tries to find the best compression method such as squeeze, crunch, etc.  It can be decompressed using <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/beehive/compress/unarc16.lbr" title="unarc16.lbr">unarc</a> or created using <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/beehive/compress/ark11.arc" title="ark11.arc">arc</a>.</dd>

  <dt>.LZH/LHA</dt>
  <dd>A common format at one time on MS-DOS and still is on the Amiga.  These can handled using <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/beehive/compress/crlzh20.lbr" title="crlzh20.lbr">crlzh</a>.</dd>

  <dt>.PMA</dt>
  <dd>This is a variant of LHA and as far as I'm aware was only used on CP/M.  These files can be handled using <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/enterprs/cpm/utils/f/pmautoae.com" title="pmautoae.com - Self Extracting Archive">PMarc</a>.</dd>
</dl>

## Decompress Only
CP/M can also decompress formats that were common on other platforms such as MS-DOS and Windows and in the case of .ZIP still is.  They can't be created under CP/M but it is useful to be able to decompress them so that you can read files created on other systems.  Unfortunately, the _unzip_ utilities I've found only unzip files created with PKZIP 1.x and therefore can't use the DEFLATE algorithm introduced by Phil Katz's 1993 release of PKZIP 2.04g.

<dl>
  <dt>.ZIP</dt>
  <dd>There are lots of files compressed as .ZIP files on the Walnut Creek CD and therefore despite not being able to decompress modern .ZIP files under CP/M it is still useful to decompress them.  They can be unzipped with <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/jsage/znode3/uploads/unzip18.lbr" title="unzip18.lbr">unzip</a>.</dd>
  <dt>.ARJ</dt>
  <dd>This was pretty common at one time but got overtaken by .ZIP.  To decompress
  use <a href="http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/jsage/znode3/uploads/cpmunarj.ark" title="cpmunarj.ark">unarj</a>.</dd>
</dl>


## Self-Extracting Archives

The [PMarc](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/enterprs/cpm/utils/f/pmautoae.com "pmautoae.com - Self Extracting Archive") tool mentioned above can also create self-extracting .com files.  Which made it really easy to distribute multiple files, but this does add extra overhead and reduce flexibility.


## Benchmarks

The various compression formats produce different results. To compare them I have taken some of the most common and used them to compress two files: ED.COM and TAO.TXT.  These files can be seen in the first two rows of the table followed by various compressed versions of them.

<table class="neatTable">
  <tr><th>Filename</th><th>Size (Kb)</th><th>Size (Records)</th><th></th></tr>
  <tr>
    <td>ED.COM</td>
    <td>10</td>
    <td>73</td>
    <td>Original binary file (CP/M Plus Editor)</td>
  </tr>
  <tr>
    <td><a href="http://www.textfiles.com/100/taoprogram.pro">TAO.TXT</a></td>
    <td>27</td>
    <td>214</td>
    <td>Original text file</td>
  </tr>
  <tr>
    <td>ED.CQM</td>
    <td>8</td>
    <td>63</td>
    <td>Squeezed version of ED.COM</td>
  </tr>
  <tr>
    <td>TAO.TQT</td>
    <td>14</td>
    <td>110</td>
    <td>Squeezed version of TAO.TXT</td>
  </tr>
  <tr>
    <td>ED.CZM</td>
    <td>7</td>
    <td>54</td>
    <td>Crunched version of ED.COM</td>
  </tr>
  <tr>
    <td>TAO.TZT</td>
    <td>11</td>
    <td>86</td>
    <td>Crunched version of TAO.TXT</td>
  <tr>
    <td>BOTH.LBR</td>
    <td>36</td>
    <td>288</td>
    <td>LBR archive containing files: ED.COM and TAO.TXT (no compression)</td>
  </tr>
  <tr>
    <td>BOTHS.LBR</td>
    <td>22</td>
    <td>174</td>
    <td>LBR archive containing files: ED.CQM and TAO.TQT (squeezed)</td>
  </tr>
  <tr>
    <td>BOTHC.LBR</td>
    <td>18</td>
    <td>141</td>
    <td>LBR archive containing files: ED.CZM and TAO.TZT (crunched)</td>
  </tr>
  <tr>
    <td>ED.ARK</td>
    <td>7</td>
    <td>56</td>
    <td>Ark version of ED.COM (Ark crunched this file)</td>
  <tr>
    <td>TAO.ARK</td>
    <td>11</td>
    <td>88</td>
    <td>Ark version of TAO.TXT (Ark crunched this file)</td>
  </tr>
  <tr>
    <td>BOTH.ARK</td>
    <td>18</td>
    <td>142</td>
    <td>Ark version containing files: ED.COM and TAO.TXT (Ark crunched both files)</td>
  </tr>
</table>

## Video of Compression and Archiving Tools

You can see some of the tools in action below.

<div class="youtube-wrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/OaIO56EmSuY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
