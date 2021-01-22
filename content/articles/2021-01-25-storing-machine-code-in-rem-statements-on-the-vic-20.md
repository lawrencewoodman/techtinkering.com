BASIC programs often contain machine code routines but they take up quite a lot of space in BASIC.  An interesting way to reduce the amount of space that they take is to store the machine code in `REM` statements.  This is much more compact and also means that we can call the routine directly from the location it is stored in memory rather than having to copy it to a further location.  This doesn't just apply to machine code, we could also do this for storing other data such as a custom character set.

## How BASIC is Stored in Memory

A BASIC program consists of a series of BASIC lines followed by two 00 octets to signify the end of the program. The BASIC statements are condensed using tokens such as $8F for `REM`.

<img src="/img/articles/vic20_basic_lines_memory_layout.png" class="img-right" style="width: 100%; margin-bottom: 2em;" title="Layout of BASIC lines in memory">



## Storing Machine Code in DATA Statements

<img src="/img/articles/vic20_machine_code_in_data_statements_basic_listing.png" class="img-right" style="width: 400px; clear: right;" title="BASIC listing with machine in DATA statements">

A machine code routine in BASIC is often stored in `DATA` statements and then copied to another area of memory for execution.  However, this uses up more memory than storing the routine in `REM` statements as we will see later.

The following BASIC program copies a machine code routine stored in `DATA` statements into locations 673-692.  The machine language routine we're using cycles the screen border and background colours and is from the article: [Hand Assembling to Machine Code on the Commodore VIC-20](/articles/hand-assembling-to-machine-code-on-the-commodore-vic-20/).


```
10 FORA=673TO692:READB:POKEA,B:NEXTA
20 DATA173,15,144,162,255,142,15,144,160,255
30 DATA136,208,253,202,208,245,141,15,144,96
40 SYS673
```


## Storing Machine Code in REM Statements

The machine code routine stored in `DATA` statements above is position independent and is represented by the following octets which we can also see in the table below.

```
AD 0F 90 A2 FF
8E 0F 90 A0 FF
88 D0 FD CA D0
F5 8D 0F 90 60
```

On an unexpanded Vic, BASIC programs start at $1001 (4097).  We would use a different location for Vics with more memory.  To create a `REM` statement with the above machine code we would enter the following in memory.  We could easily `POKE` the values from BASIC into memory starting at location 4097 ($1001) or we could use a simple hex loader or a machine language monitor.


<table class="neatTable neatBorder">
  <tr><th>Location</th><th>Octets</th><th>Explanation</th></tr>
  <tr><td>$1001</td><td>1C 10</td><td>Next line link.  Here this is also the end of BASIC program - $101C</td></tr>
  <tr><td>$1003</td><td>0A 00</td><td>Line number - 10</td></tr>
  <tr><td>$1005</td><td>8F</td><td>REM token</td></tr>
  <tr><td>$1006</td><td>20</td><td>Space character</td></tr>
  <tr>
    <td>$1007</td>
    <td>AD 0F 90 A2 FF 8E 0F 90 A0 FF 88 D0 FD CA D0 F5 8D 0F 90 60</td>
    <td style="vertical-align: top;">Machine language routine</td>
  </tr>
  <tr><td>$101B</td><td>00</td><td>End of BASIC line</td></tr>
  <tr><td>$101C</td><td>00 00</td><td>End of BASIC program</td></tr>
</table>

After we have entered the line into memory we must remember to update locations 45/46 to indicate the end of our BASIC program and the start of variables.

<br />

### Using VICMON to Create REM Statement Containing Machine Code

<img src="/img/articles/vic20_vicmon_code_in_rem_basic_listing.png" class="img-right" style="width: 400px; clear: right;" title="BASIC listing with machine embedded in REM statement, entered using VICMON">

If we have a machine language monitor, such as VICMON, then the process is really easy.  We just alter the bytes in memory, exit to BASIC, update the end of BASIC program pointer and then enter our `SYS` statement on the following line.

<br style="clear:right" />

In VICMON we first have to enable a virtual zero page otherwise the monitor would overwrite bytes in memory necessary for BASIC.

```
.E 1200
```

Enter BASIC `REM` lines containing machine code at location $1001 (4097), the start of BASIC on an unexpanded Vic.
```
.M 1001
.:1001 1C 10 0A 00 8F
.:1006 20 AD 0F 90 A2
.:100B FF 8E 0F 90 A0
.:1010 FF 88 D0 FD CA
.:1015 D0 F5 8D 0F 90
.:101A 60 00 00 00
```

Exit to BASIC.
```
.X
```

Move the pointer to end of BASIC program, which is the next location after the end of the BASIC program marker.  This is stored in LSB MSB order and here is $101E (4126).
```
POKE 45, 30
POKE 46, 16
```

Add line to jump to the machine code contained in the `REM` statement.
```
20 SYS4103
```




## Memory Use Comparison

The following BASIC statement shows how much memory is free for BASIC programs.

```
PRINT FRE(0)
```


On an unexpanded Vic, that has just been switched on, it shows 3581 bytes free.

The following table shows how much memory is used by the two programs above.
<table class="neatTable">
  <tr><th>Program Version</th><th>Memory free (bytes)</th><th>Usage (bytes)</th></tr>
  <tr><td>DATA statements</td><td>3460</td><td>121</td></tr>
  <tr><td>REM statement</td><td>3544</td><td>37</td></tr>
</table>

We can see from this table that the version of the program that stored the machine code routine in a `REM` statement used 84 bytes less memory than the one that stored the routine in `DATA` statements.  It also saved using up memory at 673-692 which could possibly be used for something else.


## Conclusion

This method is a great way to save memory in BASIC programs, however it isn't without its problems.  The machine code routine can't contain a `00` byte as this indicates the end of the BASIC line.  It isn't suitable for listings and it is a pain if we want to alter the machine code stored in the `REM` statements.  Despite this, it is an interesting method which gives us some incite into how BASIC is stored in memory and can be useful in certain situations.


## Video

The following video shows a machine code routine being entered into both `DATA` statements and `REM` statements.  It also shows the code being run directly from the area in memory where it is embedded within the `REM` statement.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/PHJeQlGrTpQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
