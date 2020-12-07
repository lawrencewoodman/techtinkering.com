The unexpanded Commodore VIC-20 only had 5K of RAM and therefore creative ways had to be found to maximize the available RAM.  The display memory would use some of this memory and therefore one option is to make use of some of the screen and colour map for code and data.

**More enthusiasm at start**

This article will only concentrate on unexpanded Vics and those with a 3K RAM expansion because this is where it is needed most.  The principles will work with systems with more memory but you will have to use alternative locations for the screen and colour map.



## Storing Code or Data in the Screen Map

The _screen map_ is 512 bytes long from location $1E00, although the visible portion for a 22 column x 23 row screen is only 506 bytes, which leaves an extra 6 bytes free.  We could use some of this for permanent program code/data or temporarily while calculations are being performed to gain extra working storage.  This means we could have up to 512 extra bytes at our disposal.  Quite a lot when you have so little to start with.

<div class="overflow-auto"><table class="neatTable neatBorder">
  <tr><th>Locations (Hex)</th><th>Locations (Decimal)</th><th>Explanation</th></tr>
  <tr><td>$1E00-$1FFF</td><td>7680-8191</td><td>Full screen map</td></tr>
  <tr><td>$1E00-$1FF9</td><td>7680-8185</td><td>Visible screen map</td></tr>
</table></div>


## Storing Data in the Colour Map

We can also store data in the _colour map_, but be aware that the colour map is stored in a 4-bit by 1Kb RAM chip.  Therefore, we can only store 4-bit values in each location.   If we read from the colour map we will find the upper 4 bites are unstable and therefore we have to AND the value with 15.  This makes it unsuitable for putting code in but it can be useful for storing data in.

There are two locations for the _colour map_, each is 512 4-bit nibbles long.  On an unexpanded Vic or one with a 3Kb RAM expansion the one at $9600 is selected.  On systems with an 8Kb RAM expansion or more the colour map at $9400 is selected.  This means that we have 512 4-bit nibbles which we are free to use in addition to any 4-bit nibbles we use from the selected colour map.

<div class="overflow-auto"><table class="neatTable neatBorder">
  <tr><th>Locations (Hex)</th><th>Locations (Decimal)</th><th>Explanation</th></tr>
  <tr><td>$9600-$97FF</td><td>38400-38911</td><td>Full colour map (selected)</td></tr>
  <tr><td>$9600-$97F9</td><td>38400-38905</td><td>Visible colour map (selected)</td></tr>
  <tr><td>$9400-$95FF</td><td>37888-38399</td><td>Full colour map (unselected)</td></tr>
</table></div>

### Reducing the Screen Size

So that the code/data stored in the normally visible screen or colour map isn't seen we can reduce the number of lines displayed.  For more information on how to do this, please see our article: [Changing Screen Dimensions on the Commodore VIC-20](/articles/changing-screen-dimensions-on-the-commodore-vic-20/).


To specify the number of rows that we want to display we alter location $9003 (36867).  In the following 'r' indicates the number of rows to display:
```
poke 36867,(peek(36867) and 129) or (2*r)
```

Therefore, if we wanted to use the bottom 3 lines of the screen map for storage we could hide them by reducing the number of rows displayed to 20.  This would create an extra 66 bytes of storage for us to use.
```
poke 36867,(peek(36867) and 129) or (2*20)
```

<br />

## Example: Using Screen Memory for Data



This is based on the [100 Doors Problem on Rosetta Code](http://www.rosettacode.org/wiki/100_doors):

<img src="/img/articles/vic20_100_doors_visual.png" class="img-right" style="width: 400px; clear: right;" title="100 Doors Program Using the Screen Map for Data Storage">

<blockquote cite="http://www.rosettacode.org/wiki/100_doors">
There are 100 doors in a row that are all initially closed.

You make 100 passes by the doors.

The first time through, visit every door and  toggle  the door  (if the door is closed,  open it;   if it is open,  close it).

The second time, only visit every 2nd door   (door #2, #4, #6, ...),   and toggle it.

The third time, visit every 3rd door   (door #3, #6, #9, ...), etc,   until you only visit the 100th door.

</blockquote>

The program lists which doors are open at the end of the last pass. These should be the first 10 perfect squares: 1, 4, 9, 16, 25, 36, 49, 64, 81, 100.

It uses the bottom 5 rows of screen memory to store the statuses of the 100 doors as either being closed (value 81 - filled circle) or open (value 87 - unfilled circle).  The values 81 and 87 are used to create a nice visual representation when we decide to show the processing in the screen map.



```
10 FOR I=38796 TO 38911:POKE I,0:NEXT I
20 D=8185-5*22:FOR I=1 TO 100:POKE D+I,81:NEXT I
30 FOR I=1 TO 100
40 FOR J=I TO 100 STEP I
50 IF PEEK(D+J)=87 THEN POKE D+J,81:GOTO 70
60 POKE D+J,87
70 NEXT J
80 NEXT I
90 FOR I=1 TO 100
100 IF PEEK(D+I)=87 THEN PRINT I,
110 NEXT I
```

In the above the following line sets the last 5 rows of the screen to black text on a white background.  It is only needed if you want to show the working out in the screen map. The loop starts from 38796 which is the start of the 19th row in the colour map.

```
10 FOR I=38796 TO 38911:POKE I,0:NEXT I
```

The code sets `D` to be the location of the first column on the 19th row of the screen.  This is where our reclaimed screen storage will begin.

```
20 D=8185-5*22:FOR I=1 TO 100:POKE D+I,81:NEXT I
```

The code then peeks and pokes to the screen map and uses it as storage.  This is instead of creating an array in Basic storage using `DIM`.


If we want to reduce the number of rows displayed to 18 so that the calculations are hidden, we would run the following first:
```
POKE 36867,(PEEK(36867) AND 129) OR (2*18)
```

<br />

## Example: Using the Colour Map for Data

The same 100 Doors Problem above could also be done by using the unused colour map at location $9400 (37888) to store data for open/closed doors.  This wouldn't alter the display and therefore we can use 0 and 1 for closed and open doors respectively.  When we read the statuses we `AND 15` to get the lower nibble because the colour map uses 4-bit RAM.

```
10 D=37888:FOR I=1TO100:POKE D+I,0:NEXT I
20 FOR I=1 TO 100
30 FOR J=I TO 100 STEP I
40 IF (PEEK(D+J) AND 15)=1 THEN POKE D+J,0:GOTO 60
50 POKE D+J,1
60 NEXT J
70 NEXT I
80 FOR I=1 TO 100
90 IF (PEEK(D+I) AND 15)=1 THEN PRINT I,
100 NEXT I
```

<br />

## Example: Using Screen Memory for Code

<img src="/img/articles/vic20_border_colours_code_in_screen_map.png" class="img-right" style="width: 400px; clear: right;" title="Running Code in the Screen Map">

The last example stores a machine language routine in the last line of the screen map.  The routine is a short piece of code to cycle the screen and border colours and is from our article: [Hand Assembling to Machine Code on the Commodore VIC-20](/articles/hand-assembling-to-machine-code-on-the-commodore-vic-20/).

<br style="clear:right"/>

```
10 for i=38886 to 38905:poke i,0:next i
20 for i=8166 to 8166+19
30 read a:poke i,a
40 next i
50 data 173,15,144,162,255,142,15,144,160,255
60 data 136,208,253,202,208,245,141,15,144,96
```

As in the first example we can see the colour map being set to black text on a white background where the code is being stored.  This is only used here to visually highlight where the code is.

```
10 for i=38886 to 38905:poke i,0:next i
```

We put the machine language routine at the end of the last line on the screen.

```
20 for i=8166 to 8166+19
```


To execute the routine once it is in screen memory we can use `SYS`.  We have to be careful not to corrupt that last line though.
```
SYS 8166
```

<br />

## Video

The examples above can be seen in the following video demonstrating code being run in the screen map and data being stored and processed in the screen and colour map.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/EkfBijC8MSU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
