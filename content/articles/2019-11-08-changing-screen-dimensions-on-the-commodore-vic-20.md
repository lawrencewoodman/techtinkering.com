To make the most of the limited amount of memory on the VIC-20, we can increase and decrease the screen size depending on our program's priorities and what we want to achieve.  If we increase the size of the screen then we also have to reduce the amount of memory our program can use, alternatively we could gain room for our program by reducing the size of the screen map.

## Change Size of Screen

To change the size of the screen displayed we need to alter a number of locations.

### $9002 (36866)

<em>Number of character columns displayed / part of screen map address / colour map location toggle</em>

<dl>
  <dt>Bit 7</dt>
  <dd>This acts as bit 9 of the 14 bit screen map address.  It also acts as a toggle for the location of the colour map.  When it is 0 the colour map is at $9400 (37888) and when it is 1 the colour map is at $9600 (38400).  Default: 1.</dd>

  <dt>Bits 6-0</dt>
  <dd>The number of character columns displayed. You will probably find that you can display fewer columns on an NTSC system than you can on a PAL system. Default: 22.<br /><br />
To alter use the following where 'c' is the number of columns:
<pre><code class="language-basic">poke 36866,(peek(36866) and 128) or c</code></pre>
  </dd>
</dl>


### $9003 (36867)

<em>Number of character lines displayed / part of raster location / character size</em>

<dl>
  <dt>Bit 7</dt>
  <dd>This is part of the raster beam location and can be ignored for this article.  Default: 1/0.</dd>

  <dt>Bits 6-1</dt>
  <dd>The number of character lines displayed multiplied by two.  You will probably find that you can display fewer rows on an NTSC system than you can on a PAL system.  Default: 46.<br /><br />
To alter use the following where 'r' is the number of rows:
<pre><code class="language-basic">poke 36867,(peek(36867) and 129) or (2*r)</code></pre>
  </dd>

  <dt>Bit 0</dt>
  <dd>The character size and can be ignored for this article.  Default: 0.</dd>
</dl>

### $9005 (36869)

<em>Screen map and character map address</em>

**Bits 7-4**
This acts as bits 13-10 of the 14 bit screen map address.  If we want a bigger screen map then we may have to move it.  If this address is moved and Basic is being used then we will have to alter the memory that Basic uses.  Default: 240.

<table class="neatTable neatTableCentre">
  <tr>
    <th>36869<br />Bits 7-4</th>
    <th>36866<br />Bit 7</th>
    <th>Screen Map</th>
    <th>Colour Map</th>
  </tr>
  <tr><td>1100</td><td>0</td><td>$1000 (4096)</td><td>$9400 (37888)</td></tr>
  <tr><td>1100</td><td>1</td><td>$1200 (4608)</td><td>$9600 (38400)</td></tr>
  <tr><td>1101</td><td>0</td><td>$1400 (5120)</td><td>$9400 (37888)</td></tr>
  <tr><td>1101</td><td>1</td><td>$1600 (5632)</td><td>$9600 (38400)</td></tr>
  <tr><td>1110</td><td>0</td><td>$1800 (6144)</td><td>$9400 (37888)</td></tr>
  <tr><td>1110</td><td>1</td><td>$1A00 (6656)</td><td>$9600 (38400)</td></tr>
  <tr><td>1111</td><td>0</td><td>$1C00 (7168)</td><td>$9400 (37888)</td></tr>
  <tr><td>1111</td><td>1</td><td>$1E00 (7680)</td><td>$9600 (38400)</td></tr>
</table>

**Bits 3-0**
This acts as bits 13-10 of the character map address and can be ignored for this article.  Default: 0.


## Memory Configurations

The locations of Basic, the screen map and the colour map default to different locations depending on the Vic's memory configuration.  On systems with less than 8K the screen map is located after Basic, whereas on systems with 8K or more the screen map is located before Basic.  Therefore, if we alter the size or location of the screen map and are using Basic, then we need to reduce the size of Basic.  The following shows the defaults for various memory configurations.


<img src="/img/articles/vic20_memory_map_basic_screen_colour.png" style="width: 100%" title="VIC-20 Memory Map Showing Basic, Screen Map and Colour Map">

<table class="neatTable">
  <tr>
    <th>Memory</th>
    <th>Basic</th>
    <th>Screen map</th>
    <th>Colour map</th>
  </tr>
  <tr>
    <td>Unexpanded</td>
    <td>$1000-$1DFF</td>
    <td>$1E00-$1FFF</td>
    <td>$9600-$97FF</td>
  </tr>
  <tr>
    <td>+3K</td>
    <td>$0400-$1DFF</td>
    <td>$1E00-$1FFF</td>
    <td>$9600-$97FF</td>
  </tr>
  <tr>
    <td>+8K</td>
    <td>$1200-$3FFF</td>
    <td>$1000-$11FF</td>
    <td>$9400-$95FF</td>
  </tr>
  <tr>
    <td>+16K</td>
    <td>$1200-$5FFF</td>
    <td>$1000-$11FF</td>
    <td>$9400-$95FF</td>
  </tr>
  <tr>
    <td>+24K</td>
    <td>$1200-$7FFF</td>
    <td>$1000-$11FF</td>
    <td>$9400-$95FF</td>
  </tr>
</table>

## Change Top of Basic
On an unexpanded Vic or one with a 3k RAM expansion, the screen map is located above the top of Basic.  The default screen map is from $1E00-$1FFF, which is 511 bytes and is enough room for the default 22x23 character display.  To make room for a bigger screen map we would need to lower the top of Basic.  On the VIC-20 the memory at the top of Basic is used to store variables.  We use the following locations to change the top of Basic.

### $37-38 (55-56)

<em>End of Basic memory</em>

This allows us to alter the end of Basic memory.  The defaults are listed in the table below.

<table class="neatTable">
  <tr><th>Memory</th><th>Default</th></tr>
  <tr><td>Unexpanded</td><td>$00/1E (0/30)</td></tr>
  <tr><td>+3K</td><td>$00/1E (0/30)</td></tr>
  <tr><td>+8K</td><td>$00/40 (0/64)</td></tr>
  <tr><td>+16K</td><td>$00/60 (0/96)</td></tr>
  <tr><td>+24K</td><td>$00/80 (0/128)</td></tr>
</table>

### $33-34 (51-52)

<em>Bottom of Basic active strings</em>

This indicates the top of available free space and defaults to the same as memory locations $37-38.

#### Example
To lower the top of Basic to $1C00 and delete all variables.  This would give enough room for a 30x30 screen:

``` basic
poke 55,0:  rem set end of basic memory low byte to $00
poke 56,28: rem set end of basic memory high byte to $1C
poke 51,0:  rem set bottom of basic strings low byte to $00
poke 52,28: rem set bottom of basic strings high byte to $1C
clr:        rem delete variables
```


## Change Bottom of Basic

On an Vic with an 8K or more RAM expansion the screen map is located below the bottom of Basic from $1000-$11FF, which is 511 bytes and is enough room for the default 22x23 character display.  To make room for a bigger screen map we would need to raise the bottom of Basic.  On the VIC-20 the memory at the bottom of Basic is where the tokenized Basic programs are stored.  We use the following locations to change the bottom of Basic.


### $FF9C (65436)

<em>Read or set bottom of Basic memory (vector)</em>

<dl>
  <dt>Carry flag</dt>
  <dd>If clear then bottom of Basic set to registers X and Y<br />
      If set then X and Y registers are set to bottom of Basic</dd>
</dl>

### $E378 (58232)

<em>Cold start Basic</em>

Before the change to the bottom of Basic will take effect, Basic needs cold starting with this routine.

#### Example

To move the bottom of Basic to $1385. This would give enough room for a 30x30 screen:

``` basic
poke 783,0:   rem clear the carry
poke 781,133: rem set x-register to $85
poke 782,19:  rem set y-register to $13
sys 65436:    rem set membot
sys 58232:    rem cold start basic
```


## Move the Picture Origin

Because the screen is displayed in relation to the top-left tv picture origin we will want to move this to centre the picture.  To read more about this look at our previous article [Moving the Picture Origin on the Commodore VIC-20](/articles/moving-the-picture-origin-on-the-commodore-vic-20/).

Here are some values that I have found work well with the [Vice emulator](http://vice-emu.sourceforge.net/).  Please note that they are shifted from the original values, not the actual values to use.  On NTSC systems 24x28 is probably the highest you can go before the screen disappears off the sides of the TV screen.

<table class="neatTable neatTableCentre">
  <tr>
    <th>Columns</th>
    <th>Rows</th>
    <th>36864<br />Bits 6-0<br />Horizontal Offset</th>
    <th>36865<br />Vertical Offset</th>
  </tr>
  <tr><td>16</td><td>16</td><td>+6</td><td>+16</td></tr>
  <tr><td>22</td><td>23</td><td>0</td><td>0</td></tr>
  <tr><td>24</td><td>28</td><td>-3</td><td>-9</td></tr>
  <tr><td>25</td><td>30</td><td>-3</td><td>-12</td></tr>
  <tr><td>27</td><td>33</td><td>-5</td><td>-19</td></tr>
</table>


## Print the ASCII Char

Once the screen is all set up we can print to it.  However, the Basic print routines expect a screen with the default 22x23 dimension.  Therefore, we can manipulate the screen map and colour map directly using the following:

<table class="neatTable">
  <tr><th>Variable</th><th>Purpose</th></tr>
  <tr><td>sm</td><td>Screen map address</td></tr>
  <tr><td>cm</td><td>Colour map address</td></tr>
  <tr><td>sw</td><td>Screen width in characters</td></tr>
  <tr><td>sc</td><td>Screen code, i.e. the character</td></tr>
  <tr><td>cl</td><td>Colour of the character</td></tr>
  <tr><td>px</td><td>X coordinate, i.e. the column - starting at 0</td></tr>
  <tr><td>py</td><td>Y coordinate, i.e. the row - starting at 0</td></tr>
</table>

``` basic
poke sm+px+(py*sw), sc: rem put screen code in screen map
poke cm+px+(py*sw), cl: rem put colour in colour map
```

## An Example Program

To demonstrate how this is all put together I have written a short Basic program which demonstrates the screen dimensions being changed to 27x33.  This is designed for unexpanded Vics and works best on PAL displays because of the size.  This program and another which will allow you to choose the dimensions and will work on PAL or NTSC systems with +3K, +8K, +16K, +24K or no memory expansion can be found in a repo on GitHub: [change_screen_dimensions_vic20](https://github.com/lawrencewoodman/change_screen_dimensions_vic20).

``` basic
  10 rem demonstrate a 27x33 screen
  20 rem lawrence woodman, nov 2019
  30 print "{clr}"

 100 rem lower top of basic to $1c00
 110 poke 55,0:poke 56,28:poke 51,0:poke 52,28:clr
 120 sm=7168:cm=37888:rem screen map: $1c00 colour map: $9400
 130 sw=27:sh=33:rem screen width/height
 140 ox=-5:oy=-19:rem picture origin x/y offset

 200 rem record initial screen settings
 210 da=peek(36866):db=peek(36867):dc=peek(36869)
 220 dd=peek(36864):de=peek(36865)

 300 rem set up screen
 310 poke 36869,240:rem set screen map: $1c00
 320 poke 36866,sw:rem width
 330 poke 36867,(peek(36867)and 128)or (sh*2):rem height
 340 poke 36864,peek(36864)+ox:rem picture origin x offset
 350 poke 36865,peek(36865)+oy:rem picture origin y offset

 400 rem clear screen
 410 for i=0 to (sw*sh)-1
 420 poke sm+i,32:poke cm+i,6
 430 next i

 500 rem print hello worlds
 510 pc=0
 520 for py=1 to sh-2
 530 px=sw-13:st$="Hello World!":gosub 5000
 540 pc=pc+1:if pc=1 then pc=2
 550 if pc>7 then pc=2
 560 next py

 600 rem wait for a key press
 610 pc=0:px=(sw-13)/2:py=sh-1:st$="Press any key":gosub 5000
 620 get a$:if a$="" then 620

 700 rem restore screen settings
 710 poke 36866,da:poke 36867,db:poke 36869,dc
 720 poke 36864,dd:poke 36865,de
 730 print "{clr}"
 740 end

4000 rem ascii to screen code - p111 mapping the vic
4001 rem args: ac - ret: sc
4010 sc=ac:if ac>127 and ac<159 then sc=0: goto 4100
4020 if ac<64 then 4100
4030 sc=ac-32
4040 if ac<96 then sc=sc-32:goto 4100
4050 if ac<128 then 4100
4060 sc=sc-32
4070 if ac>191 then sc=sc-64
4080 if ac=255 then sc=30
4100 return

5000 rem print string - args: st$, px, py, pc
5010 for i=1 to len(st$)
5020 ac=asc(mid$(st$,i,1)):gosub 4000
5030 ps=sc
5040 gosub 6000
5050 px=px+1
5060 next i
5070 return

6000 rem print char - args: px,py,ps,pc
6010 poke sm+px+(py*sw),ps:poke cm+px+(py*sw),pc
6020 return
```
<br />

If you would like to try this code with smaller screen dimensions, which may may be more appropriate for NTSC systems, then you could use set the screen dimensions to 24x28 by changing the following lines.

``` basic
 130 sw=24:sh=28:rem screen width/height
 140 ox=-3:oy=-9:rem picture origin x/y offset
```

## Video Demonstrating Changing the Screen Dimensions

You can see how the screen dimensions are changed in the following video:

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/p3mkE2FXbaM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
