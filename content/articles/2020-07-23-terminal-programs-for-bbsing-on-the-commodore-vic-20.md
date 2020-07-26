The VIC-20 introduced many people into the world of BBSing, but only a few of the many terminal programs that were available for the Vic have survived.  They each have their own pros and cons and here I review a few of them.

## VICModem Basic Type-In Terminal

<img src="/img/articles/vic20_vicmodem_basic_terminal_cbbs_nv.png" class="img-right" style="width: 500px; clear: right;" title="VICModem Basic Terminal connected to CBBS/NV">

The Commodore 1600 VICModem, released in 1982, contained a [short terminal program written in Basic](https://archive.org/details/1600VIC-20VICMODEMManual/page/n7/mode/2up) within its user manual.  However, this program had a small error on line _320_ in some of the manuals, which should read:

```
320 if a$="" or st<>0 then 360
```


It is 22 column only and converts to/from ASCII.  However, it would be easy to adapt this to use PETSCII if desired.  It is simple, but works well on an unexpanded Vic.  Unlike the other terminal programs presented here it doesn't have a menu, so you have to configure it with the correct baud rate, stop bits, parity, etc through the first line of the program.  To see how to configure this by altering line _100_ of the code have a look at the [VIC-20 Programmers Reference Guide](https://archive.org/details/VIC-20ProgrammersReferenceGuide1stEdition6thPrinti/page/n267/mode/2up "Page 252/253")

```
100 open 5,2,3,chr$(6)
```

## Victerm

<img src="/img/articles/vic20_victerm_13th_floor_bbs.png" class="img-right" style="width: 500px; clear: right;" title="Victerm in 40 column mode connected to 13th Floor BBS">

Shortly after the release of the VICModem came the [VICterm 40](http://www.zimmers.net/anonftp/pub/cbm/vic20/roms/tools/4k/Victerm%2040.prg "Victerm 40.prg") (VIC-1610) cartridge which can display in 40 columns as well as the standard 22 columns.  This improves the alignment of text from BBS's and if you were happy with the small font it could make BBSing much easier.  If you choose to keep to 22 columns then it also supports a mode which wraps words which works well.  Victerm supports modems speeds up to 2400 baud and can display PETSCII or ASCII.  The 40 column mode is single colour but the 22 column mode supports PETSCII colours.  It needs an 8k+ expansion to work and the version on [zimmers.net](http://www.zimmers.net) looks like it should be for NTSC from the screen position, but it only works in PAL mode on VICE.



## Plus/Term

<img src="/img/articles/vic20_plusterm_8bit_playground.png" class="img-right" style="width: 500px; clear: right;" title="Plus/Term in word-wrap mode connected to 8-Bit Playground">

[Plus/Term](http://www.zimmers.net/anonftp/pub/cbm/vic20/utilities/8k/Plus.term.prg "Plus.term.prg") is a type-in program, written in Basic and machine language.  It can be seen in [COMPUTE! Issue 57 / February 1985](https://www.atarimagazines.com/compute/issue57/plus_term.html "Page 88: Plus/Term For VIC & 64").  It only supports 22 columns but has a number of nice features such as the same word wrap mode as Victerm and the ability to transfer text to/from a buffer and load/save it to disk or tape.  This works well with text files and there is information in the article on how to tokenize/detokenize Basic programs to/from ASCII.  Plus/Term supports up to 2400 baud and requires 8k+ memory expansion, 16k+ if using the load/save buffers.



## Mighty Term

<img src="/img/articles/vic20_mighty_term_a2k4.com.png" class="img-right" style="width: 500px; clear: right;" title="Mighty Term in 80/2 mode connected to A2K4.com">

[Mighty Term](http://www.zimmers.net/anonftp/pub/cbm/vic20/utilities/8k/Mighty%20Term8192.prg "Mighty Term8192.prg") by [Craig Bruce](http://csbruce.com) was released in the late 1980s and was [written using a machine-language monitor](http://sleepingelephant.com/ipw-web/bulletin/bb/viewtopic.php?t=4646).  It is the most advanced terminal program available for the Vic and supports 40 column by default, as well as 22 columns and an 80 column mode using two pages.  Mighty Term is unfinished but seems to work quite well and supports both ASCII and PETSCII modes upto 2400 baud in theory, however I've only ever been able to get it working at 300 baud through VICE.  It looks like it should be for NTSC, but only works for me in PAL mode in VICE.  Sadly it lacks colour PETSCII support even in 22-column mode.  Mighty Term requires 16k+ memory expansion.


## NinjaTerm

<img src="/img/articles/vic20_ninjaterm_cottonwoodbbs.png" class="img-right" style="width: 500px; clear: right;" title="NinjaTerm connected to Cottonwood BBS">

[NinjaTerm](https://github.com/cbmeeks/NinjaTerm "GitHub repo") is the latest termiminal program that I've come across and can be download as a [.d64 image](https://commodore.software/downloads/download/66-miscellaneous-terminal-programs/11475-ninjaterm-v2-0).  It is very big and requires 24k+ memory expansion.   It doesn't offer very much for all the extra memory, but it does look good as it uses a nice fat font for its 22 column display and supports colour.  It is quite buggy however and hangs on some sites.  For the right sites though it really does look quite nice and works at upto 2400 baud on VICE.


## Tcpser
To connect to telnet BBS's over the internet from within VICE you can use [Tcpser](https://github.com/FozzTexx/tcpser) with a command such as:

```
$ tcpser -v 25232 -s 2400  -l 4
```

This would launch _tcpser_ to accept a connection from VICE on port 25232 and emulate a modem at 2400 baud using log level 4.

For a list of telnet BBSs look at:
* [CBBS Outpost](http://cbbsoutpost.servebbs.com/) for Commodore BBSs
* [telnet BBS Guide](https://www.telnetbbsguide.com/) for a list of hundreds of BBS of all sorts.

## Configuring VICE to use Tcpser

<img src="/img/articles/vice_configure_rs232_for_tcpser.png" class="img-right" style="width: 500px; clear: right;" title="Configuring VICE to connect to tcpser">

If you are using VICE to connect to telnet BBS's via _tcpser_ you need to configure the RS232 settings properly for the Userport.  I use the SDL version of VICE where I go to _Machine settings_ > _RS232 settings_.  On the GUI versions there will be a similar menu structure somewhere.

First you need to configure the Userport:

* Enable the _Userport RS232 emulation_
* Set the _Userport RS232 host device_.  This is the device used under host settings.  I use device 3 as this is already part configured for _tcpser_.
* Set the _Userport RS232 baud rate_.  This should match the baud rate you are using for _tcpser_.

Second you need to configure the _Host settings_.  I use device 3 so I'll base this around that, but you can use a different device if you wish.  The main thing is that you use the same device number as you specified for the _Userport RS232 host device_ above.

* Connect the device to _tcpser_ using the same port specified after the `-v` switch when running _tcpser_: Device 3 127.0.0.1:25232
* Set the device baud rate, as above for the _Userport RS232 baud rate_: Device 3 baud rate -> 300
* Enable IP232 protocol: Device 3 use IP232 protocol


## HAYES Modem Commands

If you are connecting via a Hayes compatible modem or _tcpser_ you will need the following modem commands to dial and hang-up the modem.  If you are using a VICModem then you can ignore these as this can't dial and therefore you have to dial manually with a normal phone and then connect the VICModem.

The modem starts off in command mode from which you can use the following commands:

<table class="neatTable">
  <tr><th>Command</th><th></th></tr>
  <tr><td>ATZ</td><td>Reset modem</td></tr>
  <tr><td>ATH0</td><td>Hang-up</td></tr>
  <tr><td>ATE0</td><td>Turn off echo</td></tr>
  <tr><td>ATE1</td><td>Turn on echo</td></tr>
  <tr><td>ATDTxxxxx</td><td>Dial xxxxx - if using a phone line then xxxxx is the number that you want to dial - if using <em>tcpser</em> then xxxx generally is hostname:port unless you have added a shortcut into the address book.</td></tr>
</table>

Once you are connected to a remote host if you want to escape to command mode you can use `+++`.  The use of this varies between modems.  The HAYES version is actually: `<pause> +++ <pause>`  the pauses are there to avoid the data you are transmitting putting the modem into command mode.  There is also a similar standard called TIES which used: `+++AT[some valid command]<cr>`  The problem with this is that, while unlikely, it was quite possible that a binary file could contain this sequence and hence the modem randomly be put into command mode without the user understanding why.  This could even by used to wind people up by putting: `+++ATH0<cr>` in text to hang-up the modems of people reading it if they were using a modem that used the TIES system rather than the HAYES system.


## Video Demonstrating the Terminal Programs

You can see the terminal programs in action connecting to various BBSs in the following video.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/CegiBW60zDY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
