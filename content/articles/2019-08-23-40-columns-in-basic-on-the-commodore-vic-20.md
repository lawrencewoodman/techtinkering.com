There are a number of programs that allow you to use 40 columns of text from Basic on a Commodore VIC-20.  This can be useful as by default the Vic's screen is 22 columns by 23 rows.  They are supplied as a machine language programs which take over some of the Basic printing routines to provide you with a display using a smaller font.  Because of the need to remap the screen each of these programs needs at least an additional 8K RAM expansion.


## VIC 40/FAT-40

<img src="/img/articles/vic20_fat-40.png" class="img-right" style="width: 500px; clear: right;" title="FAT-40">

There is a little bit of confusion surrounding the name and origin of this.  The date given by [FAT-40](http://www.zimmers.net/anonftp/pub/cbm/vic20/utilities/8k/Fat%2040.prg "Fat 40.prg") on Zimmers is 13th July 1983 and is for a PAL screen.  However, there is a program called _VIC 40_ published in [Ahoy! Magazine, October 1984](https://archive.org/details/ahoy-magazine-10/page/n43) for NTSC.  Either way they seem to be compatible as FAT-40 works with the [Ahoy! Magazine, VIC 40 Demo](http://www.zimmers.net/anonftp/pub/cbm/vic20/utilities/8k/Fat40%20Demo.prg "Fat40 Demo.prg") also on Zimmers and is dated 1984.

The demo really demonstrates how good this extension is because it shows full character sets plus hi-res graphics being used at the same time.  From the Ahoy! Magazine article it says how this program makes the Vic compatible with PET Basic programs and also demonstrates how to use this mode from machine code programs.  With an 8K RAM expansion it leaves 4466 bytes free for your Basic programs.

The PET support is quite good in that it moves the screen map to the correct location for the PET so that you can Poke directly into it and it also emulates the Sound system.  Naturally it doesn't extend the Basic to v4 which PET's often use, but other than that it is pretty good.

### PET Compatibility Tests
You can test the PET compatibility of _VIC 40_ using the following:

Switch to lowercase:

    poke 59468,14

Switch to uppercase:

    poke 59468,12

Print an A in top-left corner of screen:

    poke 32768,65


## Screen-40

<img src="/img/articles/vic20_screen-40.png" class="img-right" style="width: 500px; clear: right;" title="Screen-40">

[Screen-40](http://www.zimmers.net/anonftp/pub/cbm/vic20/utilities/8k/Screen-40.prg "Screen-40.prg") is a available for NTSC screens on Zimmers and seems to have been published in [Compute! Gazette, June 1985](https://archive.org/details/1985-06-computegazette/page/n93).  It is much the same at VIC 40, but lacks PET support.  However, it uses 653 fewer bytes and therefore with an 8K RAM expansion it leaves 5119 bytes free.

<br style="clear:right;" />

## Super Screen

<img src="/img/articles/vic20_super_screen.png" class="img-right" style="width: 500px; clear: right;" title="Super Screen">

This was a commercial program sold by Audiogenic and reviewed in [Commodore Magazine, November 1983](https://archive.org/details/commodore-user-magazine-02/page/n55).  A PAL version of it is available on a [.T64 tape image](https://onedrive.live.com/redir?resid=C546FFC678A19925!146&authkey=!AFPQpUADLooHK48&ithint=file%2Ct64 "super_screen.t64 download").

For me this version has the nicest font, however unfortunately it has an annoying behaviour in that it prints an extra new line after every print.  The included demo show this not being done, but it is cumbersome and makes Super Screen a pain to work with.

<br style="clear:right;" />

## PET Loader

<img src="/img/articles/vic20_pet_loader.png" class="img-right" style="width: 500px; clear: right;" title="PET Loader">

[PET Loader](http://www.zimmers.net/anonftp/pub/cbm/vic20/roms/tools/8k/PET%20Loader.prg "PET Loader.prg") is a cartridge for PAL systems available from Zimmers.  It is presumably meant to make it easier/possible to run PET programs written in Basic on the Vic.  However, while it patches Basic and provides 40 columns, common pokes for sound and text display don't work.  That said, because it is a cartridge, it is nice to be able to boot directly into 40 columns.  There is more [discussion](http://sleepingelephant.com/ipw-web/bulletin/bb/viewtopic.php?t=1552) about patching it to work with NTSC systems on the denial forum.

<br style="clear:right;" />

## The Big One

<img src="/img/articles/vic20_the_big_one.png" class="img-right" style="width: 500px; clear: right;" title="The Big One">

[The Big One](http://www.zimmers.net/anonftp/pub/cbm/vic20/demos.basic/unexpanded/Big%20One%20(s).prg "Big One (s).prg") is a little different from the other programs listed in this article in that it doesn't display 40 columns.  Instead, it uses the same character font for a normal Vic, but expands the number of columns displayed to 25 and the number of rows to 30.  It works on an unexpanded Vic and comes with a [demonstration](http://www.zimmers.net/anonftp/pub/cbm/vic20/demos.basic/unexpanded/Big%202.prg "Big 2.prg") program.

Because of overscan, 25 columns is just about as much as you can extend the number of columns to before they start disappearing off the side of older television set screens.  The version linked to is for PAL systems and is hosted on the Zimmers website.  I mention it here because you may find that it is more comfortable to use than the small fonts of the 40 column extensions and because it works on an unexpanded Vic.

## Video of the Extensions

You can see the extensions being used on a Commodore VIC-20 in the video below:

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/AjRAtJbWOAQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
