Word processing is possible on the VIC-20 and can be surprisingly comfortable despite the small screen text area.  Here I will show a variety of word processors each of which handles the 22 column restriction in a different way.  In many ways this is a follow-on article to: [Spreadsheets on the Commodore VIC-20](/articles/spreadsheets-on-the-commodore-vic-20/).

## VICWRITER

<img src="/img/articles/vic20_vicwriter.png" class="img-right" style="width: 500px; clear: right;" title="VICWRITER">

Commodore's [VICWRITER](http://www.zimmers.net/anonftp/pub/cbm/vic20/utilities/8k/Vic%20Writer.prg "Vic Writer.prg on zimmers.net") has an interesting approach to dealing with the 22 character width of the Vic.  It creates a display like a typewriter where the page moves as if on a carriage about the central typeface area.  The line width ruler is displayed below this.  This actually works quite well and allows us to quite comfortably type as if using a typewriter but with the benefit that we can easily move around the page to edit what we have written.


The word processor has various modes and submodes indicated at the top by 'md=' and then the mode.  The status line also indicates the current line with 'ln='.  VICWRITER starts in Primary mode ('md=P') and we can enter _Scan/edit_ mode ('md=S') using 's', this defaults to 80 character width but we can put a number after it such as 60 to indicate 60 character width.  Then press 'k' to enter _Keyboard_ mode which allows us to enter text.  It starts in _Overwrite_ mode ('md=O') and can be switched to _Insert_ mode ('md=I') with the _CTRL_ key.  We can easily move about the page using the cursor keys as well as F5/F6 to move down/up 10 lines and F7/F8 to move forward/back 10 characters.  We return to _Scan/edit_ mode using  _CLR/HOME_.

VICWRITER requires an 8Kb memory expansion and was available on diskette (VIC3305) and cassette (VIC3306).  There is a [manual on archive.org](https://archive.org/details/VICWRITER_1982_Commodore).

Overall it works well and provides an easy way to do simple word processing on the Vic.  While it is based on a typewriter it adds the ability to edit, copy, paste, handle tabs, load, save and print multiple copies of the text.

##  Quick Brown Fox

<a href="http://www.zimmers.net/anonftp/pub/cbm/vic20/roms/tools/8k/Quick%20Brown%20Fox-sys24576.prg" title="Quick Brown Fox-sys24576.prg on zimmers.net">Quick Brown Fox</a> is essentially a line editor.  It presents a menu at the start with several different operations we can perform on the text, such as Typing text, Viewing the text, Moving/copying text, Printing, etc.    To get back to the menu from one of the modes press '<big>&#8592;</big>' which acts as an Escape key.

### Type Mode

<img src="/img/articles/vic20_quick_brown_fox.png" class="img-right" style="width: 500px; clear: right;" title="Quick Brown Fox">

In _Type_ mode we can enter text from a point in the text.  This will allow us to enter text which will wrap on the screen anytime there is a space after the tenth character.  When on a line we can go back to edit what we have typed but once the line wraps or we press return then we are on a new text entry line and can only edit on that line.  If we press return the line feed is indicated with an '@' character.  When we have finished typing we can exit _Type_ mode with the Escape key '<big>&#8592;</big>', which will put us in _L.Edit_ mode, see below.

Quick Brown Fox came on a cartridge and there is a [manual on bombjack.org](http://www.bombjack.org/commodore/applications/Quick_Brown_Fox_Word_Processor.pdf "Quick Brown Fox Manual on bombjack.org").  QBF as two particularly interesting features that are not available on the other word processors:  i. It can be used with certain 40 and 80 column display adapters which would make word processing much easier.  ii.  It supports sending and receiving text via RS-232.

### Line Editing
To edit text properly we need to go into _L.Edit_ (Line Edit) mode after Typing text or from the main menu.  This will allow us to search for a piece of text to edit from or edit from the start.  We can edit one line at a time and move around within the text using the cursor keys.  Then we use one of the following keypresses to edit the text:

<table class="neatTable neatBorder">
  <tr><th>r</th><td>Replace mode</td></tr>
  <tr><th>d</th><td>Delete a character (can be pressed multiple times)</td></tr>
  <tr><th>dw</th><td>Delete a word</td></tr>
  <tr><th>ds</th><td>Delete a sentence</td></tr>
  <tr><th>dp</th><td>Delete a paragraph (upto next line feed)</td></tr>
  <tr><th>i</th><td>Insert text</td></tr>
</table>

Once we have finished editing we leave _L.Edit_ mode and return to the menu with the Escape key (<big>&#8592;</big>).



### Embedded Commands

Within the text we can use various embedded commands to format the text.  Some of them are listed below but there are quite a few more for doing things such as justifying text, setting margins, tabs, etc.

<table class="neatTable neatBorder">
  <tr><th>&sol;</th><td>Set header for display on second and subsequent pages.  Must be entered as the first thing on the first page.</td></tr>
  <tr><th>#Bnn</th><td>Insert boilerplate nn at this point in text</td></tr>
  <tr><th>#C</th><td>Center text surrounded by this</td></tr>
  <tr><th>#P</th><td>Indent a new paragraph</td></tr>
  <tr><th>#K</th><td>Stops the printer for text insertion</td></tr>
  <tr><th>#U</th><td>Start and stop underline (only available on some printers)</td></tr>
  <tr><th>#H</th><td>Start and stop bold (only available on some printers)</td></tr>
  <tr><th>#O</th><td>Start and stop overstrike (only available on some printers)</td></tr>
</table>

The `#Bnn` command allows us to insert boilerplate text.  This is text that we have created and saved separately which can be inserted at any point.  This is useful for text that is regularly used in the documents we create.  When printing we can also pause the printing and enter text using the `#K` command which is great for form letters.


## Speedscript

<img src="/img/articles/vic20_speedscript.png" class="img-right" style="width: 500px; clear: right;" title="Speedscript">

<a href="http://www.zimmers.net/anonftp/pub/cbm/vic20/utilities/8k/Speedscript%203.0.prg" title="Speedscript 3.0.prg on zimmers.net">Speedscript</a> first appeared in Compute!'s Gazette in 1984 and was updated and appeared in their various publications over the next few years.  It has a nice word wrap facility which presents more information on the screen than Quick Brown Fox as it uses nearly all the available screen width.  Speedscript doesn't have a separate mode for editing so we can edit as we go and it has great cursor movement commands so we can easily move forward/backward a character, line, word, sentence or paragraph at a time.  End of lines are indicated with '<big>&#8592;</big>' rather than '@' which is a less used character and therefore probably a better choice.  Speedscript has other functions such as search and replace as well as a delete buffer which can be used to cut/copy and paste as well as provide a crude undelete function.

### Formatting

Page formatting is done by embedding formatting codes into the text.  These are entered by pressing CTRL-£ followed by a letter to indicate the following code and then any parameters for that code.  A sample of the formatting codes is shown below:

<table class="neatTable neatBorder">
  <tr><th>C</th><td>Center text following it</td></tr>
  <tr><th>L</th><td>Left margin position - defaults to 5</td></tr>
  <tr><th>P</th><td>Page length - defaults to 66</td></tr>
  <tr><th>R</th><td>Right margin position - defaults to 75</td></tr>
  <tr><th>T</th><td>Top margin position - defaults to 5</td></tr>
</table>


Printing control is a bit clunky as we have to send printer control codes for many things such as underline and italic.  However, centering, margins and other facilities are easily done with the built-in support for them.  Speedscript is able to  print to disk which can be quite handy as then it is possible to process the output with other programs.  Alternatively, if we want to access the raw files before formatting takes place they are easily processed as they just consist of a series of screen codes.

There is a [manual on archive.org](https://archive.org/details/Computes_Speedscript/mode/2up "Compute's Speedscript manual on archive.org").




## Write Now

For completeness I want to finish by mentioning [Write Now](http://www.zimmers.net/anonftp/pub/cbm/vic20/roms/tools/8k/Write%20Now-sys41000.prg "Write Now-sys41000.prg on zimmers.nt").  It came as a catridge and seems like a good word processor but unfortunately I can't find a manual for it and therefore can't assess it fully.  The nearest I can find to a manual is on Anders Persson's site: [Write Now Instructions](http://www.boray.se/commodore/writenow.html).  It has however had very good [reviews](https://www.mocagh.org/softguide/vicsoftware.pdf "THE BEST VIC/COMMODORE SOFTWARE - vicsoftware.pdf") and therefore seems worthy of inclusion.  In addition it shows yet another way of handling the 22 column screen.  Typing is in the middle of the screen on a highlighted line with the rest of the page above and below that line.

Like Speedscript it has the concept of a delete buffer where anything we delete is stored there sequentially in the order that we delete each character.  We can use this to cut/copy and paste by first clearing it using F6 and then pasting using F5.

One odd feature that is worth pointing out is that we can use the joystick to control the cursor which doesn't seem easier than the keyboard but perhaps is more comfortable if we are just reading through text.

From what I can tell it seems like quite a usable word processor but I do find inserting text a bit of a pain as, like in BASIC, we have to make space using the insert key and then insert text into that space, which is a bit tiresome if we want to insert lots of text.  There are probably ways around this by splitting a line and rejoining but without the manual I'm not sure.


## Summary

There were many other word processors available for the VIC-20 but unfortunately binary images or manuals are not available for them.  However,  I think three of these were really good options for the VIC-20 and I encourage you to give them a go and also have a look at the video below to see them in action.


## Video

The following video shows the word processors being used.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/mrmcXoJDcOg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
