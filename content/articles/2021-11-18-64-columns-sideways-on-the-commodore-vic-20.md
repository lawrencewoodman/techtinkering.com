With a little lateral thinking and by putting the television on its side we can create a 64 column sideways text mode on the VIC-20.  This article will demonstrate this and show how it is done.  Previously we've shown 40 columns in BASIC which has been around for decades, however I have never seen anyone use this trick to get 64 columns before.

## Disclaimer

_Putting a television on it's side may not be safe and we take no responsibility for any damage or accidents caused by trying this.  The television will probably be unstable on its side and the components inside are not designed to function in this way._

## Laying out the Screen Map

<img src="/img/articles/vic20_20x12_display_240_chars.png" class="img-right" style="width: 400px; clear: right;" title="Normal layout of characters on 20x12 screen">

Normally hi-res graphics are achieved on the Vic by putting a different character in each screen location from left to right, top to bottom.  Therefore the first screen location has character 0 (@), the next character 1 (A), etc.  We can then alter pixels by just redefining these characters in the character definitions map in memory that contain those pixels.

However, because we are using the screen sideways we lay out the screen map so that character 0 is at the top right of the screen if viewed in its normal orientation, then character 1 below it and this continues down each row and to the left for each column.  If viewed sideways this would look like the same layout as is normally used.

## Character Definition Map

Each characters is defined using a series of 8 or 16 bytes depending on if we use 8x8 or 8x16 characters.  Previously we've shown [40 columns being used in BASIC](/articles/40-columns-in-basic-on-the-commodore-vic-20/ "40 Columns in Basic on the Commodore VIC-20") and this was achieved by using 4-bit wide characters and reducing the number of text columns to 20.  This allows two 4-bit characters to fit in the space of each 8-bit wide character definition and therefore provide 20x2=40 columns of text.

<img src="/img/articles/vic20_64_col_comm_simulated_char_def.png" class="img-right" style="width: 500px; clear: right;" title="Example Character Definition for 4 Simulated Characters: COMM">

For this sideways text mode we will put the character sideways and therefore each 8x16 character definition can fit four characters.  We laid out the screen map so that the characters run from left to right and top to bottom when viewed sideways.

As an example, if viewed sideways, the first four simulated characters are stored in the first 16 bytes of the character map.  To alter any of them we just copy over the relevant bytes to replace the simulated characters with others.  To make life easy we store the simulated font definitions for each character as a series of 4 bytes each representing one pixel column of 8 bits if viewed sideways.

## Screen Dimensions

The Vic allows us to [alter the screen dimensions](/articles/changing-screen-dimensions-on-the-commodore-vic-20/ "Changing Screen Dimensions on the Commodore VIC-20") and on a PAL screen we can get a maximum of about 27 columns by 33 rows.  If we used 4-bit wide characters this would allow 27x2=54 columns of text although this may be hard to fit on some television sets.  If instead we were to look at the 33 columns of text sideways on the screen this would allow 33x2=66 columns if viewed using 4-bit wide fonts on their side.

## Displaying Sideways


We configure the Vic to use 8x16 character definitions because we have to map the whole screen using the 256 characters available.  If we were to use 8x8 character definitions and use 33 rows that would only allow 256/33 = 7 columns or displayed sideways and using a 4-bit font gives 66 columns by 7 rows.  By using 8x16 character definitions we can fit 4 sideways characters into each 8x16 character definition.  This means we reduce our number of real rows displayed to 16 and can now display more columns.

<img src="/img/articles/vic20_sideways_64x14_scroll_program.png" class="img-right" style="width: 300px; clear: right;" title="The 64x14 display viewed in normal operation">

Now we can see how we get 64 columns of text sideways on the Vic by changing to 8x16 character definitions, setting the number of rows displayed on the screen to 16, using 4-bit wide simulated character definitions and fitting four sideways simulated characters per real character definition.  This gives 16 rows * 16 bit character definition / 4 sideways characters per character definition = 64 simulated columns displayed sideways.

<img src="/img/articles/vic20_sideways_64x14_scroll_program_rotated.png" class="img-right" style="width: 400px; clear: right;" title="The 64x14 display viewed sideways">

This now leaves the question of how many simulated rows.  I'm using 14 simulated rows which is 14 real columns.  The reason for this is that each real character definition is 16 bytes and therefore for 16 real rows it would take 16x16=256 bytes to define one real column.  If we have 14 simulated rows which is 14 real columns then this uses 14x256 = 3584 ($E00) bytes in the character definition map.  The Vic can only address memory up to $2000 and if we locate the character map at the lowest realistic address at $1000 then it will occupy memory at $1000-$1DFF.  The highest location we can give for the screen map is at $1E00 so the character map just fits before the screen map.  The screen map itself only needs 16 real rows by 14 real columns and therefore would use 16x14=224 ($E0) bytes.  This would mean the screen map would occupy $1E00-$1EDF and therefore code could be placed from $1EE0 upwards.

I think it may be possible to extend this to a 64x15 text mode by overlapping the screen map and character map but I haven't experimented with this yet.  If I manage it I will publish the details at a later date.

## NTSC

This works well on PAL displays but because NTSC has less screen real estate 64 columns sideways isn't really possible.  However, people in NTSC land I haven't forgotton you.  Text modes, 56x14 and 52x16 should be possible without any problem and still gives a considerable boost.

## Final Thoughts

I love 64 column displays such as on the TRS-80, Exidy Sorceror and SOL-20.  I particularly like 64x16 displays.  It's a bit of a shame I couldn't easily stretch the Vic to do 64x16; I do have an idea about how to do this in the future, although it may make the screen update a bit slow.

This text mode is naturally a trade-off, what we gain in simulated columns we lose in rows, that's without even mentioning the fact that the text is being printed sideways.

I've put some example code into a [github repo](https://github.com/lawrencewoodman/64_columns_sideways_vic20) if you want to give this a go and I'd love you hear what you think about all this and whether you think the trade-off is worth it.

## Video

The following video shows the 64 column text mode in action.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/L3VilLfuehI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
