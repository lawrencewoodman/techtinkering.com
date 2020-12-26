The VIC-20 is a very flexible little machine and allows us to choose which area of memory represents the screen map.   One interesting thing we can do is use this to visualize a section of memory such as the zero page.  This can create quite interesting patterns on the screen and allows us to actually see some of the processing of the Vic in action.


## Moving the Screen Map

<img src="/img/articles/vic20_screen_map_address_diagram.png" class="img-right" style="width: 500px; clear: right;" title="How Screen Map is Calculated">

The VIC chip uses a 14-bit screen map address and uses bits in locations $9002 (36866) and $9005 (36869) to set it.  Because of the peculiar way the VIC chip works when we alter location $9005, bit 7 must be set even though it will be changed to 0 in the final address for the screen map.  Bit 7 of location $9002 also determines the location of the colour map.  The remaining bits of $9005 set the character map address and they default to 0 on an unexpanded Vic.  The remaining bits of $9002 set the number of columns displayed and they default to 22.


<div class="overflow-auto"><table class="neatTable neatBorder">
  <tr><th class="centre">Screen Map</th><th class="centre">Colour Map</th><th class="centre">$9005 Bits 7-4</th><th class="centre">$9002 Bit 7</th><th class="centre">Notes</th></tr>
  <tr><td class="centre">$0000</td><td class="centre">$9400</td><td class="centre">1000<br />(128)</td><td class="centre">0</td><td>Display pages 0 and 1</td></tr>
  <tr><td class="centre">$1000</td><td class="centre">$9400</td><td class="centre">1100<br />(192)</td><td class="centre">0</td><td>Default screen map with 8Kb+ RAM expansion</tr>
  <tr><td class="centre">$1E00</td><td class="centre">$9600</td><td class="centre">1111<br />(240)</td><td class="centre">1<br />(128)</td><td>Default screen map for unexpanded Vics or those with 3Kb RAM expansion</td></tr>
</table>

Compute credits Jim Butterfield with demonstrating how you can set the screen map to start at location 0 which allows you to observe the first two pages of memory.  Well nearly, because the screen can only display 506 bytes so the end of the second page can't be seen on the screen.


## Page 0 - Zero Page

The _zero page_ is important because it allows machine code programs to use shorter and faster instructions.  BASIC and the Kernal make heavy use of the locations in this page for frequently used data storage and therefore it is an interesting section of memory to look at.

On an unexpanded Vic we don't need to worry about what is already in locations 36869 and 36866 and therefore we can easily set the colour map to black text on a white background to make all the locations visible and then set the screen map to location 0 using:

```
FOR I=37888 TO 37888+505:POKE I,0:NEXT I
POKE 36869,128:POKE 36866,22
```

While the screen is showing the zero page we could enter and run code to see what happens in zero page.  An easy demonstration would be to enter a `FOR` loop:

```
FOR I=1 TO 1000:PRINT"HELLO":NEXT I
```


## Page 1 - The Stack

The 6502 reserves 256 bytes for the stack beginning at location $100 (256).  However, Basic uses locations $140-$1FF (320-511) as a stack and the preceding locations for a tape error log and for converting floating point numbers to ASCII.

We could demonstrate the BASIC stack being filled by repeatedly calling a nested `GOSUB` routine:

```
10 GOSUB 10
```


## Interesting Locations

There are a number of interesting locations and patterns that we can see.  There are lots of '@' symbols which would be $00 in memory.  There are two locations that we can see counting.  There is also a location that oscillates between '@' and 'A' which would be between $00 and $01 in memory.

<video autoplay loop muted playsinline src="/video/articles/vic20_visualize_zero_page_annotated.mp4" class="video-centre" style="width: 100%; max-width: 600px; clear: right;" title="Screen Map Mapped to Zero Page"></video>


<div class="overflow-auto"><table class="neatTable neatBorder">
  <tr><th>Location</th><th>Row</th><th>Column</th><th>Purpose</th></tr>
  <tr><td class="centre">$A0-$A2<br />(160-162)</td><td class="centre">8</td><td class="centre">7</td><td>Jiffy Clock counting one-sixtieths of a second</td></tr>
  <tr><td class="centre">$C5 (197)</td><td class="centre">9</td><td class="centre">22</td><td>Matrix coordinate of last key pressed,  64 if none pressed</td></tr>
  <tr><td class="centre">$CB (203)</td><td class="centre">10</td><td class="centre">6</td><td>Matrix coordinate of current key pressed,  64 if none pressed</td></tr>
  <tr><td class="centre">$CD (205)</td><td class="centre">10</td><td class="centre">8</td><td>Cursor countdown before blink.  Normally counts 20 jiffies before blink of cursor.</td></tr>
  <tr><td class="centre">$CF (207)</td><td class="centre">10</td><td class="centre">10</td><td>Cursor blink status 1 = reversed character, 0 = non-reversed.  We can see alternating between '@' which is 0 and 'A' which is 1.</td><tr>
  <tr><td class="centre">$D3 (211)</td><td class="centre">10</td><td class="centre">14</td><td>Cursor position within the logical screen line.  Keep pressing a key to see increment from '@' which is 0 and then press return to see it revert to '@'.</td></tr>
  <tr><td class="centre">$D7 (215)</td><td class="centre">10</td><td class="centre">18</td><td>ASCII value of last key pressed.  Change to lowercase to see key pressed.</td></tr>
  <tr><td class="centre">$100-$1FF<br />(256-511)</td><td class="centre">12</td><td class="centre">15</td><td>The 6502 stack</td></tr>
  <tr><td class="centre">$140-$1FF<br />(320-511)</td><td class="centre">15</td><td class="centre">13</td><td>The BASIC stack</td></tr>
</table></div>


## Video

The following video shows zero page being visualized and exercised to create interesting patterns.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/Fzd40ar8x8A" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

