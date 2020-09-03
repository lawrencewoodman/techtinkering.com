CP/M is by default a text-only affair.  However, many of the machines that can run CP/M have hardware that would allow them to display graphics.  As BBSing started to grow so too did the distribution of electronic images in formats such as: .RLE, .PCX, .GIF and .BMP.  Therefore, programs were written on popular CP/M machines to display these pictures.  Each program was hardware dependant because there were no standard operating system calls to interact with the graphics hardware.  There was GSX-80, but you still needed a hardware dependant screen driver for each machine and not that many machines had them, plus it was pretty slow.  There were also programs that printed the image to a printer rather than display on screen.  This was particularly useful for those machines that didn't have sufficient graphical hardware or a version couldn't be found or adapted for them.


The main image formats, prior to 1990, were are as follows.

## .RLE

<img src="/img/articles/cpm_v1050_rle.png" class="img-right" style="width: 300px; clear: right;" title="VTCRLE on a Visual 1050">

CompuServe developed what is probably the earliest widespread image format in the mid eighties, possibly before 1985.  It encodes black and white images in resolutions of 128×96 or 256×192, compressed using [Run Length Encoding](https://en.wikipedia.org/wiki/Run-length_encoding).  This had the most widespread support and I've found the following _RLE_ viewers for CP/M on the Walnut Creek CD:

* [PIXRLE.ARK](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/starlet/pixrle.ark "pixrle.ark") - RLE graphics viewer for the NEC CP/M Starlet/8500
* [VTCRLE.LBR](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/vis1050/vtcrle.lbr "vtcrle.lbr") - RLE graphics viewer for the Visual 1050.  This can display an _.RLE_ image as well as save a screen to _.RLE_.  It only works with 'high-resolution' 256x192 images, which the author states virtually all were then anyway.  It was written by Alex Fetesoff in 1988.
* [RDUMP10.LBR](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/graphics/rdump10.lbr "rdump10.lbr")  - RLE graphics viewer, which can display on a TeleVideo TPC-1 or TS-803 graphics screen or print to EPSON FX, SEIKOSHA SP-1000 or 1200, or almost any other EPSON-FX 'work-a-like' printer on any CP/M computer.   It was written in Basic and Assembler by Dave Clifford in 1987.


## MacPaint: .MAC, .PNTG, .PIC, etc

MacPaint was released in 1984 by Apple and its image format used a form of _Run Length Encoding_ called [PackBits](https://en.wikipedia.org/wiki/PackBits).  The images are always 576×720 and monochrome.  I found one viewer for this on the Walnut Creek CD:

* [PRINTEP v0.6](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/beehive/utilitys/prntep06.ark "prntep06.ark") - Prints Electric Paintbrush/Macpaint images to a MicroBee DP80/100 printer or if you have a Microbee Premium or 256TC, to the screen.  Dated 1992.


## .PCX

<img src="/img/articles/cpm_c128_pcx.png" class="img-right" style="width: 500px; clear: right;" title="PCX'EM on a C128">

ZSoft Corporation released _[PCX](https://en.wikipedia.org/wiki/PCX)_ in 1985 as an image format for its _PC Paintbrush_ graphics editing software.  _PCX_ stands for PiCture eXchange and supported a version of _Run Length Encoding_ to compress the images.  Over time several releases of the format were made to support more features and colour palettes.

The only viewers I found for _PCX_ files were written by Steve Goldsmith in 1993 for the Commodore 128 with an 80 column monitor.  They work reasonably well but can only view monochrome images and there is some image distortion.  The best variants can be found on the Walnut Creek CD:

* [PCX'EM 1.0](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/enterprs/cpm/utils/f/pcxem10.arc "pcxem10.arc") - This can view 640x200 images and works with a 16k VDC.  If you do have a 64k VDC then it has a mode which supports this and works faster.
* [PCX'EM 1.1](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/enterprs/cpm/utils/f/pcxem11.arc "pcxem11.arc") - This can view 640x480 images but requires a 64k VDC and a monitor capable of displaying in interlace mode.


## .GIF

<img src="/img/articles/cpm_pcw_gif.png" class="img-right" style="width: 300px; clear: right;" title="GIFVIEW on an Amstrad PCW">

As colour support and display resolutions increased CompuServe decided to release a new image format in 1987, called the _[Graphic Interchange Format](https://en.wikipedia.org/wiki/GIF)_ (GIF).  This supported upto 256 colours and its use of LZW data compression was much more efficient than RLE.  The original release was known as GIF87 and a further release was made in 1989 called GIF89a which added several features, most notably animation.  However, not all _GIF_ viewers can view the '89 version of the files so there is a program called [GIFSTRIP](http://www.classiccmp.org/cpmarchives/cpm/mirrors/ftp.demon.com/pub/cpm/gifstrip.arc "gifstrip.arc") to convert GIF89a images to GIF87.  There are a few GIF viewers for CP/M:

* **GIFVIEW v1.05** - A GIF viewer for the Amstrad PCW.  It was released by John Elliott in 1996 and is available from his [John Elliott's Amstrad CP/M Software](https://www.seasip.info/Cpm/software/amstrad.html) page as _PWGIFSEA.COM_.  This is a self-extracting archive and the program allows you to view image files in GIF87 or GIF89a format as monochrome or greyscale images.

* **GIFPAS** - The Turbo Pascal source for a GIF viewer/printer.  This is useful if you want to adapt a GIF viewer to your own machine.  It can be found on the [Walnut Creek CD](http://www.classiccmp.org/cpmarchives/ftp.php?b=cpm/Software/WalnutCD/) _uuencoded_ within [two emails](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/graphics/gifcpm.zip "gifcpm.zip") about it, dated 1992.

* **VALGIF** - This was available for the Epson QX-10/QX-16.  I've seen it mentioned in a few places, such as on [Vintage Computer Federation Forum](http://www.vcfed.org/forum/archive/index.php/t-48690.html), which has documentation dating to 1989.  The documentation says that it could also view _RLE_ files, but I haven't been unable to obtain a copy of the program.


## .BMP

<img src="/img/articles/cpm_pcw_bmp.png" class="img-right" style="width: 300px; clear: right;" title="PCWBMP on an Amstrad PCW">

Microsoft developed the _[BMP](https://en.wikipedia.org/wiki/BMP_file_format)_ format in 1987 to store Device Independent Bitmaps and was first used in Windows 2.0.  It supports compression using RLE or a form of Huffman coding.  I found one viewer for this format:

* **PCWBMP v1.5** - A BMP viewer for the Amstrad PCW, released by John Elliott in 1996 and available from [John Elliott's Amstrad CP/M Software](https://www.seasip.info/Cpm/software/amstrad.html) page as _PWBMPSEA.COM_.  It can only view uncompressed _.BMP_ files in monochrome or greyscale.


## Miscellaneous Formats

There were many other formats supported by various applications, which tended to be specific to a single machine or hardware manufacturer.  Some of the most notable are:

<dl>
  <dt>Stop Press: .SPC, .CUT</dt>
  <dd>A Desktop publishing application for the Amstrad PCW.</dd>

  <dt>Valdocs</dt>
  <dd>An integrated software suite featuring a word processor; spreadsheet; charting, graphing and painting applications; email and more.  It was written for the Epson QX-10/QX-16.</dd>

  <dt>DR Graph</dt>
  <dd>A graphing program written by Digital Research which used a GSX driver.</dd>

  <dt>DR Draw</dt>
  <dd>A drawing program written by Digital Research which used a GSX driver.</dd>
</dl>


## Video Demonstrating the Image Viewers

You can see some of the images viewers in action on various types of machine in the following video.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/P9krXcdcV9A" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
