petcat is a utility provided with the [VICE](http://vice-emu.sourceforge.net/) Commodore emulator that you can use to convert Basic source code contained in ASCII text files to .PRG files or vice versa.  It is also able to convert ASCII text files to and from PETSCII .SEQ files.  This makes it a great utility for cross-development purposes.

## Convert Basic Source Code in an ASCII Text File to a .PRG File

If the input file is Basic source code stored as an ASCII file then petcat will tokenize this to create a .PRG file as its output.  Blank lines will be ignored, but the Basic keywords should be in lowercase because of they way that Commodore Basic stores them.  If, for example, you used `lI` in your Basic source code it would be converted to `list`.

In the following example we specify tokenizing with Basic v7.0 using the `-w70` switch and the output file with `-o program.prg`.  The `--` switch tells petcat to stop processing command line switches and the file to convert is `program.bas` at the end.


``` text
$ petcat -w70 -o program.prg -- program.bas
```

## Convert a .PRG File to an ASCII Text File

If the input file is a .PRG file then petcat will de-tokenize this to create an ASCII text file as its output.

In the following example we specify de-tokenizing Basic v2.0 using the `-2` switch and the output file with `-o program.bas`.  The `--` switch tells petcat to stop processing command line switches and the file to convert is `program.prg` at the end.

``` text
$ petcat -2 -o program.bas -- program.prg
```


## Basic Versions

petcat supports many different flavours of Basic that came as standard with 8-bit Commodore computers as well many extended and alternative Basics.  Further options are listed in the [VICE manual](http://vice-emu.sourceforge.net/vice_15.html).  Below are the options used to specify the standard flavours of Basic.  These are used after the `-w` switch if you want to tokenize and without if you want to de-tokenize.

<table class="neatTable">
  <tr><th>Option</th><th>Version</th><th>Computers</th></tr>
  <tr><td>1p</td><td>Basic v1.0</td><td>PET</td></tr>
  <tr><td>2</td><td>Basic v2.0</td><td>C64/VIC20/PET</td></tr>
  <tr><td>3</td><td>Basic v3.5</td><td>C16/C116/Plus/4</td></tr>
  <tr><td>40</td><td>Basic v4.0</td><td>PET/CBM2</td></tr>
  <tr><td>70</td><td>Basic v7.0</td><td>C128</td></tr>
</table>

## Unprintable / Special Characters

Commodore Basic programs can contain characters that aren't printable in ASCII, so petcat uses a set of mnemonics to encode these.  Below are some of the most commonly used.

<table class="neatTable">
  <tr><th>Mnemonic</th><th>Explanation</th></tr>
  <tr><td>{blk}</td><td>Colour: black</td></tr>
  <tr><td>{wht}</td><td>Colour: white</td></tr>
  <tr><td>{red}</td><td>Colour: red</td></tr>
  <tr><td>{cyn}</td><td>Colour: cyan</td></tr>
  <tr><td>{pur}</td><td>Colour: purple</td></tr>
  <tr><td>{grn}</td><td>Colour: green</td></tr>
  <tr><td>{blu}</td><td>Colour: blue</td></tr>
  <tr><td>{yel}</td><td>Colour: yellow</td></tr>
  <tr><td>{orng}</td><td>Colour: orange</td></tr>
  <tr><td>{brn}</td><td>Colour: brown</td></tr>
  <tr><td>{lred}</td><td>Colour: light red</td></tr>
  <tr><td>{lgrn}</td><td>Colour: light green</td></tr>
  <tr><td>{lblu}</td><td>Colour: light blue</td></tr>
  <tr><td>{gry1}</td><td>Colour: grey1</td></tr>
  <tr><td>{gry2}</td><td>Colour: grey2</td></tr>
  <tr><td>{gry3}</td><td>Colour: grey3</td></tr>
  <tr><td>{rvon}</td><td>Control: reverse on</td></tr>
  <tr><td>{rvof}</td><td>Control: reverse off</td></tr>
  <tr><td>{clr}</td><td>Control: clear screen</td></tr>
  <tr><td>{home}</td><td>Control: home</td></tr>
  <tr><td>{inst}</td><td>Control: insert</td></tr>
  <tr><td>{del}</td><td>Control: delete</td></tr>
  <tr><td>{up}</td><td>Cursor: up</td></tr>
  <tr><td>{down}</td><td>Cursor: down</td></tr>
  <tr><td>{left}</td><td>Cursor: left</td></tr>
  <tr><td>{rght}</td><td>Cursor: right</td></tr>
</table>

### Example Using the Mnemonics
The following example clears the screen using the `{clr}` mnemonic and then prints a line of black text using `{blk}` followed by a line of red text using `{red}`, finally it finishes the program by changing the text colour to blue using `{blu}`.

``` basic
10 print "{clr}"
20 print "{blk}this text is black"
30 print "{red}this text is red"
40 print "{blu}"
```

## Autostarting a .PRG in VICE
VICE allows you to autostart a .PRG file by putting it on the command-line.  You may need to use the `-basicload` switch (depending on how `AutostartBasicLoad` is set in your config) to load it using `,8` instead of `,8,1`.  The following will autostart the basic program, `program.prg`, using VICE's VIC-20 emulator.

``` text
$ xvic -basicload program.prg &
```

## Video Demonstrating petcat

You can see petcat being used in the following video:

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/MZHS4qVfmvc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
