VICMON is a machine language monitor released by Commodore in 1982 and is great for programming the VIC-20.  Its interactive nature means that it can often be quicker to develop via this rather than using a fully fledged assembler because it's easy to enter, alter and test code without having to wait for an assembler to load source code, assemble it, write a binary and then load the resulting binary separately.  This also makes it good for debugging our programs and understanding other people's better.  Jeff Minter wrote in [Compute! Gazette Issue 2, 1983](https://archive.org/details/1983-08-computegazette/page/n53/mode/2up) that he programmed all his games in the past with the VICMON cartridge before switching to a Commodore 64 assembler-editor.

This article will show how to write programs in assembly language with VICMON by creating a simple music player and then showing how to move code about to extend it.  There is an accompanying [video](#article-video) which should make the process easy to understand and show off the power of VICMON for creating assembly language programs on the Vic.


## Contents

This is quite a long article and will make more sense if read from start to finish.  However, once read it may be useful to go over certain sections.  I would also recommend looking at the [video](#article-video) as this should make the use of VICMON much clearer.

* [Designing a Simple Music Player](#article-designing-a-simple-music-player)
* [Video](#article-video)
* [Starting VICMON](#article-starting-vicmon)
* [Virtual Zero Page](#article-virtual-zero-page)
* [Entering the Program](#article-entering-the-program)
* [Saving/Loading the Program](#article-saving-loading-the-program)
* [Running the Program](#article-running-the-program)
* [Expanding the Program](#article-expanding-the-program)
* [Stepping Through the Code](#article-stepping-through-the-code)
* [Breakpoints](#article-breakpoints)
* [Running the Program from BASIC](#article-running-the-program-from-basic)
* [VICMON Commands Table](#article-vicmon-commands-table)
* [The Final Program Listing](#article-the-final-program-listing)



<h2 id="article-designing-a-simple-music-player">Designing A Simple Music Player</h2>

The simple music player we're going to create isn't an example of a good music player but it is complex enough to demonstrate how to use VICMON.

The code will use the following locations on the Vic.

<table class="neatTable neatBorder">
  <tr><th>Location</th><th>Mnemonic</th><th>Note</th></tr>
  <tr><td>$A2</td><td>TIME</td><td>Jiffy clock - the actual RTC updates locations $A0-$A2, however we'll just use the last byte to count time in one-sixtieths of a second</td></tr>
  <tr><td>$900C</td><td>VICCRC</td><td>Set frequency of sound oscillator 3, which has the highest pitch range.  Bit 7 also enables/disables the oscillator.</td></tr>
  <tr><td>$900E</td><td>VICCRE</td><td>Set volume, it can take a value from 0-15 with 0 being off.  Bits 7-4 also controls the auxiliary colour for multicolour mode but we'll ignore that here.</td></tr>
</table>

Unless the program we want to write is very simple it is best to write it out in assembly language first.  It is generally best to keep all the data for the program together in one area.  I find it easier, when using VICMON, to keep the data at the start of the code because this makes it much easier to keep track of when moving code around.  I recommend breaking code into small subroutines which can be easily tested and where possible use position independent code so that they can be easily moved.

Our simple music player will start by looking like the following in assembly language.

```
TIME    = $A2             ; Jiffy clock
VICCRC  = $900C           ; Frequency of sound oscillator 3
VICCRE  = $900E           ; Volume

          JMP MAIN

          ;-----------------------------------
          ;            Data
          ;-----------------------------------

          ; Mary had a Little Lamb
          ; stored as note,length,note,length,...
          ; and terminated by a 0
NOTES     .byt $CC,$1E,$C6,$1E,$BF,$1E,$C6,$1E
          .byt $CC,$1E,$CC,$1E,$CC,$3C
          .byt $C6,$1E,$C6,$1E,$C6,$3C
          .byt $CC,$1E,$D5,$1E,$D5,$3C
          .byt $CC,$1E,$C6,$1E,$BF,$1E,$C6,$1E
          .byt $CC,$1E,$CC,$1E,$CC,$1E,$CC,$1E
          .byt $C6,$1E,$C6,$1E,$CC,$1E,$C6,$1E
          .byt $BF,$78,$00


          ;-----------------------------------
          ;            Code
          ;-----------------------------------
MAIN
          ; Set volume to maximum
          LDA #$0F
          STA VICCRE

          LDX #$00        ; Zero index for start of notes

          ; Load note
NXTNOTE   LDA NOTES, X
          BEQ END         ; If a 0, then finish

          ; Play note
          STA VICCRC      ; Turn on Speaker 3 with note in Accumulator
          INX             ; Move index to note length

          ; Delay for length of note
          LDA #$00
          STA TIME        ; Zero Jiffy Clock 1/60 of a second timer
WAIT      LDA TIME
          CMP NOTES, X    ; Check if clock has reached note length
          BNE WAIT

          ; Break between notes
          LDA #$00
          STA VICCRC
          STA TIME
WAIT2     LDA TIME
          BEQ WAIT2       ; Wait for 1/60 of a second

          ; Move to next note/length pair
          INX
          BNE NXTNOTE     ; If not 0, then loop and get next note

          ; Set volume to 0
END       LDA #$00
          STA VICCRE
          BRK
```

<h2 id="article-video">Video</h2>

The following video complements this article as it shows each of the steps used in creating the music player using VICMON and demonstrates the machine language monitor in action.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/1PwD4NLHU44" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>


<h2 id="article-starting-vicmon">Starting VICMON</h2>

[Vicmon ](http://www.zimmers.net/anonftp/pub/cbm/vic20/roms/tools/4k/Vicmon-6000.prg "Vicmon 4k Cartridge image") can be downloaded from the [zimmers.net 4k tool ROMS archive](http://www.zimmers.net/anonftp/pub/cbm/vic20/roms/tools/4k/) for use with emulators.  If using an emulator attach the cartridge at $6000 or if using a physical machine plug in the cartridge and switch on the Vic.  We can start the machine language monitor from BASIC with the `SYS` command.

```
SYS 24576
```

<h2 id="article-virtual-zero-page">Virtual Zero Page</h2>

VICMON uses locations in zero page and we don't want those corrupted by our program when it runs so we can create a virtual zero page using the `E` command.  On an unexpanded VIC we can use memory up to the screen map at $1E00.  In this case we'll create a virtual zero page at location $1500.

```
.E 1500
```
 
<h2 id="article-entering-the-program">Entering the Program</h2>

To enter this program use the `A` and `M` commands at a location just a little way into the BASIC memory area.  As we enter the program we'll create a memory map and note down any addresses which we'll want to refer to later.  Where there are references to forward addresses that we don't know yet we can note down the locations that need editing once they are known.  I normally use the current address as the temporary address.

The following is how the first few lines of the above program would look if entered it into VICMON.  We start with the `A` command to assemble from location $1100 and stop assembling by pressing RETURN without entering a mnemonic.  In the jump we don't know the address of `MAIN` so specify the current address for the `JMP` and note it down for altering later.

```
.A 1100 JMP $1100
.A 1103
```

The tune we are going to use is 'Mary Had a Little Lamb' and is stored as note,length,note,length,etc and terminated with a `00`.  We enter the note/length pairs of the tune using the `M` command to alter memory directly following the `JMP`.  Note down $1103 as the address of `NOTES`.

```
.M 1103
.:1103 CC 1E C6 1E BF
.:1108 1E C6 1E CC 1E
.:110D CC 1E CC 3C C6
.:1112 1E C6 1E C6 3C
.:1117 CC 1E D5 1E D5
.:111C 3C CC 1E C6 1E
.:1121 BF 1E C6 1E CC
.:1126 1E CC 1E CC 1E
.:112B CC 1E C6 1E C6
.:1130 1E CC 1E C6 1E
.:1135 BF 78 00
```

We can now enter the rest of the program using the `A` command, which starts as follows.  Any forward references that are as yet unknown can be noted down and altered at the end.  Here we will note down $1138 as the address of `MAIN`.

```
.A 1138 LDA #$0F
.A 113A STA $900E
.A 113D LDX #$00
.A 113F LDA $1103,X
.A 1142 BEQ $1142
```

The end of the code finishes as follows and we leave the `A` command by pressing RETURN without entering an assembly statement.  We'll note $1161 as `END` and $1166 as the last instruction in the code.

```
.A 1161 LDA #$00
.A 1163 STA $900E
.A 1166 BRK
.A 1167
```


Finally we can alter the code in the locations we recorded by using the `D` command.  This will disassemble the location specified and allow us to edit it using the cursors to correct the location.

<table class="neatTable">
  <tr><th>Instruction Location</th><th>Instruction</th><th>New Address Operand</th></tr>
  <tr><td>$1100</td><td><code>JMP MAIN</code></td><td>$1138</td></tr>
  <tr><td>$1142</td><td><code>BEQ END</code></td><td>$1161</td></tr>
</table>


```
.D 1100
., 1100 JMP $1100
```

After editing and pressing RETURN it will look like:

```
.A 1100 JMP $1138
.A 1103
```

We'll also do this for location $1142, turning `BEQ $1142` into `BEQ $1161`.





<h2 id="article-saving-loading-the-program">Saving/Loading the Program</h2>

Before running the program, save using the `S` command which takes a name, followed by device (01 for cassette, 08 for diskette), and then start and end address.  Note that the end address has to be one past the last byte we want to save.

```
.S "MARY",01,1100,1167
```

To load the program we use the `L` command which takes an optional device number.  If the device number isn't specified then it defaults to 01 - the cassette.

```
.L "MARY"
```


<h2 id="article-running-the-program">Running the Program</h2>

Our music player starts at $1100 and to execute it we simply use the `G` command.

```
.G 1100
```

<h2 id="article-expanding-the-program">Expanding the Program</h2>

It would be nice if the music player displayed the name of the piece of music it was playing.  Altering this program is a chance to demonstrate some of the other powerful features of VICMON.  The complete [final program listing](#article-the-final-program-listing) can be found at the end of the article.

We'll alter the code to create two subroutines, one to display the name of the piece of music and the other will be created from our current code to play the music.  This will leave the start of the `MAIN` code block looking like this.

```
VICCRE  = $900E           ; Volume
CCHROUT = $FFD2           ; Output character to current output device

MAIN      JSR PNAME       ; Display the name of the music being played
          JSR PLAY        ; Play the music
          BRK

          ; PNAME subroutine
          ; Print the name of the piece of music
PNAME     LDX #$00
NAMELOOP  LDA NAME, X
          BEQ ENDPNAME
          JSR CCHROUT     ; Output character
          INX
          BNE NAMELOOP
ENDPNAME  RTS


          ; PLAY subroutine
          ; Play the piece of music

          ; Set volume to maximum
PLAY      LDA #$0F
          STA VICCRE

          LDX #$00        ; Zero index for start of notes
```

The subroutine `PLAY` would be altered to end with `RTS` rather than its former `BRK`.

The string 'MARY HAD A LITTLE LAMB', preceded by a CLR (clear screen), followed by RETURN and terminated with a 0 would be represented by the following 25 bytes.

```
93 4D 41 52 59
20 48 41 44 20
41 20 4C 49 54
54 4C 45 20 4C
41 4D 42 0D 00
```

For demonstration purposes it would be good to put the name of the music before its notes in memory and therefore we have to move the memory from the notes to the end of the code to create space.  We know from above that this area occupies $1103-$1166.  We'll use the `T`, transfer command, to move this area by 25 bytes to make room for the name string so that `NOTES` is now at $111C.

```
.T 1103 1166 111C
```

We can now enter our `NAME` string at location $1103.

```
.M 1103
.:1103 93 4D 41 52 59
.:1108 20 48 41 44 20
.:110D 41 20 4C 49 54
.:1112 54 4C 45 20 4C
.:1117 41 4D 42 0D 00
```

If we wanted to we could see our string in memory as reverse ASCII using the `I`, inspect command.

```
.I 1103 111B
```

We could also hunt for a string such as 'MARY' with the `H` command which would return $1104.

```
.H 1100 1200 'MARY
```

We'll need to find the new location of `MAIN`.  An easy way to do this would be by finding the end of our `NOTES` as we know that `MAIN` comes straight after that.  We can do this using the `H` to find the last three bytes of the `NOTES`.  The command below will search from $111C to $1200 for the bytes `BF 78 00`.

```
.H 111C 1200 BF 78 00
```

This `H` command returns $114E so we can add 3 to that and get $1151 as the new address of `MAIN` which we can confirm with the `D` command.

```
.D 1151
., 1151 LDA #$0F
., 1153 STA $900E
```

We now need to make room for the `JSR` and `BRK` commands as well as the `PNAME` subroutine.  We can quickly workout that we need 21 bytes for this and hence use the `T` command again to move the code a further 21 bytes.  However, we need to find the end of the code, the final `BRK`.  We could run through disassembling the code from $1151 until we found it but a quick way would be to use the `H` command again to find the last three bytes of the code representing `$900E` followed by `BRK` which is `0E 90 00` in machine code.

```
.H 1151 1200 0E 90 00
```

This returns $117D and hence by adding 2 we know that the `BRK` is at location $117F.  We now have the information needed to move our code.

```
.T 1151 117F 1166
```

Next, we'll  turn our music playing code into a subroutine by changing the final `BRK` to an `RTS`.  We'll use the `H` command again to find it in its new position.

```
.H 1166 1200 0E 90 00
```

This returns $1192 so we can then use the `D` command to edit location $1194 and turn it into an `RTS`.

Next we want to repoint the `PLAY` subroutine to the correct location for `NOTES`.  To do this we use the `N` command which will renumber absolute addresses in the code.  Our subroutine runs from location $1166 to $1194 and we know that `NOTES` is now 25 ($19) bytes higher in memory.  We only want to alter absolute addresses that fall in the range $1100 to $1200.  I have included the disassembly before and after to illustrate what this does to the absolute addresses, but we wouldn't normally need this. 

```
.D 116D
., 116D LDA $1103,X

.N 1166 1194 0019 1100 1200

.D 116D
., 116D LDA $111C,X
```


We can now enter our new code for the `JSR` and `BRK` commands along with the `PNAME` subroutine.

```
.A 1151 JSR $1151
.A 1154 JSR $1166
.A 1157 BRK
.A 1158 LDX #$00
.A 115A LDA $1103,X
.A 115D BEQ $115D
.A 115F JSR $FFD2
.A 1162 INX
.A 1163 BNE $115A
.A 1165 RTS
.A 1166
```

Finally we can use the `D` command to alter the code at the following locations:

<table class="neatTable">
  <tr><th>Instruction Location</th><th>Instruction</th><th>New Address Operand</th></tr>
  <tr><td>$1100</td><td><code>JMP MAIN</code></td><td>$1151</td></tr>
  <tr><td>$1151</td><td><code>JSR PNAME</code></td><td>$1158</td></tr>
  <tr><td>$115D</td><td><code>BEQ ENDPNAME</code></td><td>$1165</td></tr>
</table>


Before running this code it would be worth saving it once again in case we have made any mistakes.

```
.S "MARY2",01,1100,1195
```

We can now run our extended music player.

```
.G 1100
```



<h2 id="article-stepping-through-the-code">Stepping Through the Code</h2>

VICMON has a number of commands to step through the code.  In order to do this we could start by using the `W` command to walk through the code one instruction at a time by pressing RETURN for each instruction to be run.  If we come to a `JSR` instruction we may not want to go through each instruction of the subroutine it is going to call and instead use the `J` command to call it and then return at the instruction it returns to.

We can begin by walking through the code from the start using the `W` command.  This will execute the initial `JMP` and look like the following if we keep pressing RETURN.

```
.W 1100
 1151 JSR 1158
 1158 LDX #00
 115A LDA 1103,X
 115D BEQ 1165
 115F JSR FFD2
```

At this point we could press RETURN to continue stepping through the `CCHROUT` subroutine at $FFD2 however this isn't our code and probably doesn't need testing so instead we can press `J` to jump to the subroutine, run it, and return without having to step through each of its instructions.  In our code this would output the first character in the string which is the `CLR` character and hence it would clear the screen and we could continue walking through as follows.

```
 1162 INX
 1163 BNE 115A
```

We can return to the VICMON prompt by pressing STOP.  If we wanted to inspect the registers we could use the `R` command.  We can even change the registers by altering the line with their contents and pressing RETURN.

```
.R
   PC  SR AC XR YR SP
.;1163 20 93 01 00 F3
```

If we wanted to continue execution of the rest of the program we would just use the `G` command and execution would continue until the `BRK` was executed.


<h2 id="article-breakpoints">Breakpoints</h2>

We may decide that we want to continue execution of the rest of the `PNAME` subroutine without walking through each instruction.  We could therefore set a breakpoint at $1154 which is the `JSR PLAY` instruction to call our `PLAY` subroutine.  Then to continue execution we use `G`.

```
.B 1154
.G
```

This would display our tune name and then break at location $1154 without calling the `PLAY` subroutine.  VICMON would display the registers and wait at its prompt.  We could then decide how to proceed either by using `W` to walk through the subroutine, `J` to execute it and return or `G` to continue execution until a `BRK` is executed. 


If we want to remove the breakpoint we can use the `RB` command.  One nice feature of the `B` command is that we can follow the address with another argument to say how many times it will be reached before breaking out of the code, e.g. we could say `B 1163,0005` and execution would stop the 5th time location $1163 is reached.  

Using breakpoints and walking through code is a great way to test subroutines before running a whole program.

## Quick Trace

If we want to run our program and be able to interrupt it at any point we can use the `Q` command to run the program at a slower pace and if we press STOP+X it will interrupt it and display the contents of the registers.  The `Q` command will also check for a breakpoint and if reached will switch to walk mode.  If we are using a virtual zero page it will run very slowly however and therefore we probably only want to use this when running very specific pieces of code.


## Fill

The final command I want to mention is the `F` command which can be used to fill an area of memory with a value.  e.g. to fill the area of memory from $1000 to $1200 with 00 we would use:

```
.F 1000 1200 00
```

<h2 id="article-running-the-program-from-basic">Running the Program from BASIC</h2>

We can exit to BASIC using the `X` command but if we want to be able to run our program from BASIC we need to turn the `BRK` into a `RTS` as the BASIC `SYS` command will expect this in order to return to BASIC properly.

```
.A 1157 RTS
.A 1158
.X
```


We can run our program, at location $1100 (4352), from BASIC using the `SYS` command.

```
SYS 4352
```
<h2 id="article-vicmon-commands-table">VICMON Commands Table</h2>

Below are all the commands that can be used within VICMON.  Operands can be separated with either a ' ' or ',' unless a ',' is specified.  For more information have a look at the [VICMON User Manual](https://archive.org/details/VICMachineCodeMonitor/mode/2up).

<table class="neatTable neatBorder">
  <tr><th>Command</th><th style="width: 14em;">Parameters</th><th>Explanation</th></tr>
  <tr><td>A</td><td>address opcode operand</td><td>Assemble code starting from <em>address</em></td></tr>
  <tr><td>B</td><td>address<br /><br />address,n</td><td>Set a breakpoint so that execution will stop if instruction at <em>address</em> is about to be executed.  If <em>n</em> is specified then will only stop after execution has reached this point <em>n</em> times.</td></tr>
  <tr><td>D</td><td>address [address]</td><td>Disassemble machine code at first <em>address</em> or between the two <em>addresses</em> to assembly language</td></tr>
  <tr><td>E</td><td>address</td><td>Enable a virtual zero page at <em>address</em> so that VICMON doesn't corrupt zero page with its variables</td></tr>
  <tr><td>F</td><td>address address value</td><td>Fill the memory between the two <em>addresses</em> (inclusive) with <em>value</em></td></tr>
  <tr><td>G</td><td>[address]</td><td>Execute a program at the current <em>PC</em> (Program Counter) or <em>address</em> if specified.</td></tr>
  <tr><td>H</td><td>address address data</td><td>Search for <em>data</em> in memory range specified.  <em>data</em> can be a number of bytes to search for or a string if we proceed it with a <em>'</em></td></tr>
  <tr><td>I</td><td>address [address]</td><td>Interpret and display printable Commodore ASCII codes at <em>address</em> or in memory range supplied</td></tr>
  <tr><td>J</td><td></td><td>Jump to a subroutine and return without single stepping while running under the 'W' command</td></tr>
  <tr><td>L</td><td>"filename",device</td><td>Load file called <em>filename</em> from <em>device</em> into memory at the location it was originally saved from.</td></tr>
  <tr><td>M</td><td>address [address]</td><td>Display memory at first <em>address</em> or between the two <em>addresses</em> and allow us to alter it</td></tr>
  <tr><td>N</td><td>address address offet lowLimit highLimit<br /><br />address address lowLimit highLimit W</td><td>Reassign absolute addresses used by instructions in memory range that occur between <em>lowLimit</em> and <em>highLimit</em> so that they have <em>offset</em> added to them.  If <em>W</em> is used then the range is a word table.</td></tr>
  <tr><td>Q</td><td>[address]</td><td>Run program at a slower pace.  Can be interrupted with STOP+X</td></tr>
  <tr><td>R</td><td></td><td>Display registers and allow them to be edited</td></tr>
  <tr><td>RB</td><td></td><td>Remove breakpoint</td></tr>
  <tr><td>S</td><td>"filename",device,address,address</td><td>Save memory between the two <em>addresses</em> to <em>device</em>.  The last address must be one bigger than the address at the last byte that we want to save.</td></tr>
  <tr><td>T</td><td>address address destAddress</td><td>Transfer memory in range of first two <em>addresses</em> to <em>destAddress</em></td></tr>
  <tr><td>W</td><td>address [address]</td><td>Walk through program executing one instruction at a time</td></tr>
  <tr><td>X</td><td></td><td>Exit to BASIC</td></tr>
</table>



<h2 id="article-the-final-program-listing">The Final Program Listing</h2>

The final program would look like the following if it were written in Assembly language.

```
RTN_CH  = $0D             ; RETURN character
CLR_CH  = $93             ; CLR - Clear screen character
TIME    = $A2             ; Jiffy clock
VICCRC  = $900C           ; Frequency of sound oscillator 3
VICCRE  = $900E           ; Volume
CCHROUT = $FFD2           ; Output character to current output device

          JMP MAIN

          ;-----------------------------------
          ;            Data
          ;-----------------------------------

          ; Name of the piece of music
NAME      .byt CHR_CH
          .asc "MARY HAD A LITTLE LAMB
          .byt RTN_CH, 00

          ; Mary had a Little Lamb
          ; stored as note,length,note,length,...
          ; and terminated by a 0
NOTES     .byt $CC,$1E,$C6,$1E,$BF,$1E,$C6,$1E
          .byt $CC,$1E,$CC,$1E,$CC,$3C
          .byt $C6,$1E,$C6,$1E,$C6,$3C
          .byt $CC,$1E,$D5,$1E,$D5,$3C
          .byt $CC,$1E,$C6,$1E,$BF,$1E,$C6,$1E
          .byt $CC,$1E,$CC,$1E,$CC,$1E,$CC,$1E
          .byt $C6,$1E,$C6,$1E,$CC,$1E,$C6,$1E
          .byt $BF,$78,$00


          ;-----------------------------------
          ;            Code
          ;-----------------------------------

MAIN      JSR PNAME       ; Display the name of the music being played
          JSR PLAY        ; Play the music
          RTS             ; Use BRK if running from VICMON

          ; PNAME subroutine
          ; Print the name of the piece of music
PNAME     LDX #$00
NAMELOOP  LDA NAME, X
          BEQ ENDPNAME
          JSR CCHROUT     ; Output character
          INX
          BNE NAMELOOP
ENDPNAME  RTS


          ; PLAY subroutine
          ; Play the piece of music

          ; Set volume to maximum
PLAY      LDA #$0F
          STA VICCRE

          LDX #$00        ; Zero index for start of notes

          ; Load note
NXTNOTE   LDA NOTES, X
          BEQ END         ; If a 0, then finish

          ; Play note
          STA VICCRC      ; Turn on Speaker 3 with note in Accumulator
          INX             ; Move index to note length

          ; Delay for length of note
          LDA #$00
          STA TIME        ; Zero Jiffy Clock 1/60 of a second timer
WAIT      LDA TIME
          CMP NOTES, X    ; Check if clock has reached note length
          BNE WAIT

          ; Break between notes
          LDA #$00
          STA VICCRC
          STA TIME
WAIT2     LDA TIME
          BEQ WAIT2       ; Wait for 1/60 of a second

          ; Move to next note/length pair
          INX
          BNE NXTNOTE     ; If not 0, then loop and get next note

          ; Set volume to 0
END       LDA #$00
          STA VICCRE
          RTS
```
