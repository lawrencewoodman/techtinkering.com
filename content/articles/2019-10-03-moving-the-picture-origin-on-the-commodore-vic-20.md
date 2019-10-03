The VIC-20's VIC chip provides a simple yet flexible video display and one of the features that can be quite useful is the ability to alter the picture origin on the screen.  This feature allows us to move the position that the screen displays on the TV up and down or left and right by changing either of two memory locations.

## Horizontal TV Picture Origin

Location 36864 ($9000).

<dl>
  <dt>Bit 7</dt>
  <dd>The interlace bit, which we'll ignore for this article.  Default: 0.</dd>
  <dt>Bit 0-6</dt>
  <dd>The horizontal origin.  To move the picture origin to the left
reduce the number and to move it to the right increase the number.
Every change moves the picture by 4 pixels.
Default: 5 on NTSC systems, 12 on PAL systems.</dd>
</dl>



## Vertical TV Picture Origin

Location 36865 ($9001).

The vertical origin.  Every change moves the picture by 2 pixels.
Default: 25 on NTSC systems, 38 on PAL systems.


## Simple Vertical Scroll Program

<img src="/img/articles/vic20_simple_vertical_scroll.gif" class="img-right" style="width: 400px; clear: right;" title="Simple Vertical Scroll Program">

The program below simply scrolls the screen from a position off the bottom up to the default origin at the top.  Both programs store the default location and therefore will work on PAL or NTSC systems.

You may want to run each program with the normal colour scheme as well as with alternative colour schemes which make the scrolling look better.  For example to change to a black background and border with a yellow text:

``` basic
POKE 36879,8:POKE 646,7
```

### Basic

``` basic
10 D=PEEK(36865)
20 FOR X=190 TO D STEP -1
30 POKE 36865, X
40 FOR Y=1 TO 3:NEXT
50 NEXT
```

### Assembler

Below is a simple assembler program to do the same as the Basic program.  It could easily be entered using Vicmon, please see [Beginning Assembly Programming on the Commodore VIC-20](/2013/04/16/beginning-assembly-programming-on-the-commodore-vic-20/) for more details on how to use it.  The program is only small so it could fit in the tape buffer at location 828 ($33C).

``` asm6502
      JMP MAIN
DFLT  NOP          ; VAR: Default horizontal picture origin minus one
MAIN  LDX $9001
      DEX
      STX DFLT     ; Store default horizontal picture orign
      LDA #$BE     ; Begin with picture origin off screen
LOOP  STA $9001    ; Change horizontal picture origin
      LDX #$09
WAIT  LDY #$FF
WAI2  DEY
      BNE WAI2
      DEX
      BNE WAIT
      SBC #$01     ; Move picture origin up one
      CMP DFLT     ; Is horizontal picture origin back at default?
      BNE LOOP
      BRK
```

## Simple Horizontal Scroll Program

The program below simply scrolls the screen from a position off the bottom up to the default origin at the top.  Both programs store the default location and therefore will work on PAL or NTSC systems.  As with the horizontal scroll program above it is worth experimenting with different screen colours.

### Basic

``` basic
10 D=PEEK(36864)
20 FOR X=60 TO D STEP -1
30 POKE 36864, X
40 FOR Y=1 TO 6:NEXT
50 NEXT
```

## Video of Simple Scrollers

You can see the scrollers being written in Basic and Assembler in the video below:

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/w_O2D14L6e8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
