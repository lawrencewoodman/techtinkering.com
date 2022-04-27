There are many utilities available for CP/M to compare the differences between files and to distribute those differences.  All the utilities in this article can be found on the Walnut Creek CD.

## Binary File Comparison

The easiest type of comparison is between two binary files such as between two .COM files.  Here we just want to know which bytes of changed and at which location.  This can be particularly useful for discovering locations to patch a .COM file if the documentation isn't forthcoming or to create a tool to automate the process.  Each tool below offers something different.

### COMPARE

The earliest program I have found to detect if binary files differ is
[COMPARE](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/filutl/compare.com "COMPARE.COM from Walnut Creek CD: /cpm/utils/filutl/").  It is
one of the many utilities created by [Ward Christensen](https://en.wikipedia.org/wiki/Ward_Christensen) and although this version is from 1978 the [source code](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/filutl/compare.asm  "COMPARE.ASM from Walnut Creek CD: /cpm/utils/filutl/") shows that it was first released in 1977 and therefore supports the 8080.  It is quite a simple utility which compares two files, displays the first difference and then stops.  Due to its simplicity it weighs in at just 2Kb.

### KOMPARE


<img src="/img/articles/cpm_kompare.png" class="img-right" style="width: 600px; clear: right;" title="KOMPARE comparing two files: HELLO.TXT and HI.TXT">

My favourite binary comparison program is [KOMPARE](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/lambda/soundpot/f/kompare.lbr "KOMPARE.LBR from Walnut Creek CD: /lambda/soundpot/f/") which displays 8 rows of 16 bytes for each file, one after the other with its ASCII equivalent on the side.  Where the bytes are the same they are clearly marked in the second file.  The addresses displayed start at 0100h for a .COM file or 0000h for all other files.  KOMPARE.COM is only 2Kb but unfortunately requires a Z80.  The archive also includes COMPARE.COM which seems to be based on COMPARE.COM mentioned previously.  The author of KOMPARE mentions that they use COMPARE when trying to disassemble and reassemble, to easily find differences as they go along without seeing all the differences at one go.

### DIFCOM

<img src="/img/articles/cpm_difcom16.png" class="img-right" style="width: 600px; clear: right;" title="DIFCOM comparing two files: HELLO.TXT and HI.TXT">

[DIFCOM v1.6](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/filutl/difcom16.lbr "DIFCOM16.LBR from Walnut Creek CD: /cpm/utils/filutl/") was released in 1983 by Harry J Smith along with its PL/I source code.  It is similar to KOMPARE in that it displays using a 16 byte row with ASCII on the side.  However, DIFCOM displays 16 bytes of one file immediately followed by 16 bytes of the next file.  Another significant difference is that the files can't be specified on the command line as they have to be entered interactively.  On the plus side you can send the output to a printer, file or to the console.  DIFCOM16.COM is 15Kb and supports the 8080.

### COMP

<img src="/img/articles/cpm_comp13.png" class="img-right" style="width: 600px; clear: right;" title="COMP comparing two files: HELLO.TXT and HI.TXT">

The simplest utility here is [COMP v1.3](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/filutl/comp13.lbr "COMP13.LBR from Walnut Creek CD: /cpm/utils/filutl/"), released in 1987.  It compares two files and displays their differences side by side along with the address of the difference for each byte that differs.  The addresses start at 0100h and there is no accompanying ASCII display of the bytes.  COMP is only 1Kb and supports the 8080.


## Text File Comparison

Unlike binary file comparison, text comparison looks at lines of text and tries to sync matching lines so that only the lines that have changed or have been inserted or removed are shown.  This is great for all sorts of situations where it is important to see how a text file changed such as a source code file if multiple people are working on it.

### TEXTCOM

<img src="/img/articles/cpm_textcom.png" class="img-right" style="width: 500px; clear: right;" title="TEXTCOM comparing two files: HELLO.TXT and HI.TXT">


When it comes to comparing text files, [TEXTCOM v1.6](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/txtutl/textcom.lbr "TEXTCOM.LBR from Walnut Creek CD: /cpm/utils/txtutl/"), released by G. Nigel Gilbert in 1983, is one of the most configurable programs and provides a nice clear output showing the differences between files.  It takes options to say how many lines are needed to sync files, whether to use the high-bit (for Wordstar, etc), whether you want to send output to a file or printer, etc.  The output often looks similar to that of DIF described next.  TEXTCOM.COM is 12Kb and supports the 8080 processor.

### DIF / SSED

Chuck Forsberg says, in his 1981 release document for [DIF/SSED v2](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/txtutl/dif-ssed.lbr "DIF-SSED.LBR from Walnut Creek CD: /cpm/utils/txtutl/"), that he wanted to find a better way of distributing software updates.

<blockquote cite="http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/txtutl/dif-ssed.doc">
Lately (if not sooner) it has become obvious that there
must be a better and cheaper way to distribute software updates
to changing programs than to transmit all of the new files in
their totality, even though only a few lines in each have been
changed.
</blockquote>

The library contains executable files DIF2.COM and SSED2.COM.  The first, DIF2.COM, will output the file differences in a similar way to TEXTCOM but has the additional ability to unsqueeze input files.  However, the biggest difference is that it can output an editor script which contains the differences in a format which can be used by SSED2.COM to recreate the second file from the first.  This is great when you want to just distribute the changes you have made to files without having to distribute complete new files.

<img src="/img/articles/cpm_dif22.png" class="img-right" style="width: 500px; clear: right;" title="DIF comparing two files: HELLO.TXT and HI.TXT">

The utilities work pretty well partly because DIF puts CRC values into the editor scripts which SSED then checks to ensure that the correct input file is being operated on.  However, there are a couple of things to watch because of the way that CR/LF and ^Z are handled, recreated files may not be exact copies of the original.  This is expected behaviour and is explained in its [accompanying documentation](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/txtutl/dif-ssed.doc "DIF-SSED.DOC from Walnut Creek CD: /cpm/utils/txtutl/").

The programs do have a couple of bugs: Sometimes the last line number is reported inaccurately when showing differences between files; Occasionally SSED2 will hang if it reaches the end of the input file unexpectedly.

Both of these utilities have been updated with versions that are smaller and faster but no longer support the BDS style pipes.  They are both 10Kb and continue to support the 8080.  They are released separately as: [DIF v2.2](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/txtutl/dif22.lbr "DIF22.LBR from Walnut Creek CD: /cpm/utils/txtutl/") and [SSED v2.2](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/cpm/utils/txtutl/ssed22.lbr "SSED22.LBR from Walnut Creek CD: /cpm/utils/txtutl/").


## Video

The following video shows the utilities being used.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/TKO8k9vUb2M" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
