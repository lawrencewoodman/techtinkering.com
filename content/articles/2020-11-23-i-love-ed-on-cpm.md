I love ED on CP/M.  It's often derided but I think it's just misunderstood and with a little practise its true value can shine through.  It's easy to learn and only has about 25 commands but these can be combined and once you get used to it, most editing tasks are pretty quick.  If I'm editing text that is made up of separate lines, ideally not more than the width of the terminal, I find it excellent.  It does have a line limit of 128 characters so for continuous prose I will switch to something like Wordstar, but for editing source code and config files on CP/M, it's my first choice.

ED came as standard with CP/M and is only 7k for CP/M 2.2 and 10k for CP/M Plus.  One advantage of ED is that it will work both with teleprinters and video terminals without having to be configured for each device.  It is also good at manipulating large files even when the system is short of memory.

<img src="/img/articles/cpm_ed_copy_paste.png" class="img-right" style="width: 400px; clear: right;" title="Copying and Pasting with ED">

Like many early editors, ED is a modal editor which you start in command mode and while in this mode you can view existing text, move between lines and points in the line.  It allows you to do standard operations such as copy and paste, inserting text from other files, searching for and replacing text, etc.  When we want to enter input mode, we can use the 'I' command.  This is much like VI, except that you can only enter text in the non-command mode but not edit it.  To exit data input mode and return to command mode you use ^Z (CTRL-Z).  These commands can be combined together and one of the most powerful facilities that ED has is the 'M' Macro command to repeat sequences of commands.

Upon executing ED it creates a temporary output file and as you write out from ED it goes to this temporary file.  When editing a file we append text from it into the memory buffer and save to the temporary output file as we go or at the end.

ED keeps track of a number of values such as where it is in the source file,  the line number in the memory buffer and the character pointer (CP) on the line.  These are altered as you move around the file and memory buffer.

I'm not going to give a fuller explanation of how to use ED here because the CP/M 2.2 Operating Manual has a good section on the [CP/M Editor](http://www.gaby.de/cpm/manuals/archive/cpm22htm/ch2.htm).  I do, however, want to show it being used properly in the video below.  Further down in this article I have highlighted some useful command sequences.



## An Example Macro

ED has a macro facility which allows you to repeat a sequence of commands as many times as you like.  This makes it a good example of the power of ED and the following is a typical macro which searches through the memory buffer and displays any occurrences of the text 'CPM', pauses in case you want to stop the macro and then replaces it with 'CP/M'.
```
MFCPM^Z0TT6Z-3CSCPM^ZCP/M^Z
```

The 'M' command will run the sequences of commands that follows it until an error is raised, such as end of file.  If we wanted to we could prepend 'M' with a number to indicate the number of times we want it to run.  I'll break down each command in the sequence below:

<table>
  <tr><td><code>M</code></td><td>Run the following command sequence until an error</td></tr>
  <tr><td><code>FCPM^Z</code></td><td>Find 'CPM' and leave Character Pointer (CP) after it</td></tr>
  <tr><td><code>0T</code></td><td>Display the line up to CP</td></tr>
  <tr><td><code>T</code></td><td>Display the rest of the line from CP to end </td></tr>
  <tr><td><code>6Z</code></td><td>Pause</td></tr>
  <tr><td><code>-3C</code></td><td>Move CP back 3 characters</td></tr>
  <tr><td style="padding-right: 2em;"><code>SCPM^ZCP/M^</code></td><td>Substitute 'CPM' for 'CP/M'</td></tr>
</table>

`^Z` in the above is CTRL-Z and indicates the end of an argument for a command.

## Video

The video below shows ED being used properly and some of the things that make it great, including searching and replacing text, copying and pasting, macros and handling files bigger than the available memory.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/7pqaj050X7g" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>



## Common Command Sequences

Below are some useful command command sequences which may be overlooked when reading the manual for ED.

<div class="overflow-auto"><table class="neatTable neatBorder">
  <tr><th>Sequence</th><th>Explanation</th></tr>
  <tr><td>#A</td><td>Load whole file into buffer</td></tr>
  <tr><td>0A</td><td>Load enough of the file to fill half the buffer.  This is great for large files</td></tr>
  <tr><td>#W0A</td><td>Save entire buffer and load more of the source file, enough to fill half of the buffer.  Useful to move through large files.</td></tr>
  <tr><td>0W</td><td>Write half of the buffer to the new file.  Useful to make room of the buffer is full.</td></tr>

  <tr><td>-B</td><td>Move to end of the last line in the buffer</td></tr>
  <tr><td>0L</td><td>Move CP to beginning of line</td></tr>
  <tr><td>L-2C</td><td>Move to end of line before the &lt;cr&gt;&lt;lf&gt; sequence</td></tr>
  <tr><td>0P</td><td>Display page from CP without moving CP</td></tr>
  <tr><td>0LT</td><td>Move CP to beginning of line and display line (Should this be +/-n ??)</td></tr>
  <tr><td>0T</td><td>Type line up to but not including CP</td></tr>
  <tr><td>0TT</td><td>Type whole line without moving CP</td></tr>
  <tr><td>0T&lt;cr&gt;T</td><td>Type whole line without moving CP.  Display up to CP on first list and from CP on next line.  This is useful to see where CP is on line.</td></tr>
  <tr><td>B#T</td><td>Display the whole buffer</td></tr>
  <tr><td>KI</td><td>Replace a line</td></tr>
  <tr><td>0K</td><td>Delete up to CP on current line</td></tr>
  <tr><td>S^L^Z</td><td>Join current line with next</td></tr>
  <tr><td>I^L^Z</td><td>To split a line at CP</td></tr>
  <tr><td>0V</td><td>Print free/total memory buffer stats</td></tr>
  <tr><td>0X</td><td>Empties the temporary default exchange file: X$$$$$$$.LIB, used by the <em>X</em> command</td></tr>
</table></div>

In the table above the following holds true:

<dl>
  <dt>#</dt><dd>Represents the highest value for n</dd>
  <dt>^L</dt><dd>CTRL-L - Stands for carriage return sequence &lt;cr&gt;&lt;lf&gt;</dd>
  <dt>^Z</dt><dd>CTRL-Z - Indicates the end of a command's argument</dd>
  <dt>&lt;cr&gt;</dt><dd>Carriage Return - Actually pressing the <em>Return</em> key</dd>
</dl>


<br />

## Do You Like ED Too?

I know that I'm in the minority, but I'm sure there must be other people who also like ED.  I'd love to hear if I'm not alone in this.  You can leave comments via the links below or via the YouTube video above.
