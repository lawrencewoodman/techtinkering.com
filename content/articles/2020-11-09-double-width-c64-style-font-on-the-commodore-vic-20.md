The C64 used a fatter double-width font because the video quality of early VIC-IIs wasn't very good.  Therefore they had to make the C64's font fatter than the VIC-20's.  However, this fatter font look quite nice and there's an easy way of replicating something similar on the VIC-20.

Rather than loading in a whole new font we can double the width of the existing font stored in ROM to create a new fatter font in RAM, which we can then point to.


## Standard Character Definitions

<img src="/img/articles/vic20_standard_letter_a_close_cropped_small.png" class="img-right" style="width: 300px; clear: right;" title="Standard VIC-20 letter 'A' Character Definition">

Each character definition is stored in ROM and for this demonstration we'll base our new fatter font on the uppercase characters stored from location 32768 ($8000).  Because this example is for an unexpanded VIC-20 we'll only use the first 64 characters.

The Vic uses 8x8 fonts as default and each character definition is stored as a series of 8 bytes with each byte representing a row of the definition.


## Fat Double-width Character Definition

<img src="/img/articles/vic20_fat_letter_a_close_cropped_small.png" class="img-right" style="width: 300px; clear: right;" title="Fat double-width letter 'A' Character Definition">

To create the double-width font we get the value of each line of the original font, double it and then _OR_ it with the original value.  This has the effect of doubling each pixel's width in the character definition.

This looks like the following where `a` equals the original value of the row in the character definition and `b` is the new value.

``` text
b := a or (a*2)
```

All we need to do then is go through each row of each character definition and store the results in RAM.  Once we have stored them in RAM, we use location 36869 ($9005) to set the character map address to our location in RAM.

## A Short Program to Create a Fat Font

The following program will use the first 64 characters of the uppercase character set to create a double-width font.  Because we're only altering the first 64 characters it means that the reverse characters aren't defined as usual so the cursor won't blink properly nor will the characters above 63 be defined properly.

### Assembly

First we'll create a little routine in assembly language to create the double-width font in RAM from location 7168 ($1C00).  This location is being used because we are creating a custom character set with 64 entries and 7680 (Start of screen memory) - 512 (8*64 characters) = 7168.

``` asm6502
TMP       = $0A                ; Store result of shift

            ldy  #$00
loop        lda  $8000,y       ; Get row of character from ROM
            tax
            asl                ; Double the value for the row
            sta  TMP
            txa
            ora  TMP
            sta  $1C00,y       ; Store row of character in RAM
            lda  $8100,y       ; Get row of character from ROM
            tax
            asl                ; Double the value for the row
            sta  TMP
            txa
            ora  TMP
            sta  $1D00,y       ; Store row of character in RAM
            iny
            bne  loop
            rts
```



### Machine Code

Next we assemble the routine to machine code using location $02A1-$02C0 to store it in.

``` text
a0 00 b9 00 80 aa 0a 85 0a 8a 05 0a 99 00 1c
b9 00 81 aa 0a 85 0a 8a 05 0a 99 00 1d c8 d0
e3 60
```

### BASIC

Finally we create a short program to load the machine code routine into memory, execute it and point to the new character map.

``` basic
10 poke 52,28:poke 56,28:clr
20 for i=673to704:read a:poke i,a:next i
30 sys 673
40 poke 36869,255
50 data 160,0,185,0,128,170,10,133,10,138,5,10,153,0,28
60 data 185,0,129,170,10,133,10,138,5,10,153,0,29,200,208
70 data 227,96
```

<img src="/img/articles/vic20_fatfont_run_and_listing_prerun.png" class="img-right" style="width: 400px; clear: right;" title="Double-width fat font listing before run">

<img src="/img/articles/vic20_fatfont_run_and_listing_postrun.png" class="img-right" style="width: 400px; clear: right;" title="Double-width fat font listing after run">

It is worth highlighting a few points in the code:
* Location 51/52 points to the bottom of BASIC active strings and hence the top of
  available free space.  On an unexpanded system it defaults to: 7680 ($1E00), by poking 28 ($1C) into 52 this lowers it to 7168 ($1C00).
* Location 55/56 point to the end of BASIC memory.  On an unexpanded system it defaults to: 7680 ($1E00), by poking 28 ($1C) into 56 this lowers it to 7168 ($1C00).
* The command `clr`, clears program variables and registers the bottom of BASIC active strings and end of BASIC memory.
* Location 673 ($02A1) is the location we assembled the machine code to.  There is an area of memory from 673-767 ($02A1-$02FF) which is used user user indirect vectors or other storage and hence is a good location to put our machine code routine.
* Location 36869 controls the location of the character set.  Ee set it to 255 as this sets the location to 7168 ($1C00), just below the screen map at 7680 ($1E00).  To see more about setting the character map location look at: [Mapping the Vic, p.129-133](https://archive.org/details/COMPUTEs_Mapping_the_VIC_1984_COMPUTE_Publications/page/n149/mode/2up).


## Video Demonstrating Fat Font

The double-width fat font can be seen in the following video.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/NeRNb4vB54U" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
