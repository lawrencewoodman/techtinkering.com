Getting the address of a BASIC variable can be useful if you want to pass data to a machine code routine or want to access the bytes of a variable directly to improve speed and reduce garbage collection.

## Getting Variable Address with BASIC

The easiest way to get the address of a variable from BASIC is by using `SYS` to call the _EVLVAR_ routine at 53387 ($D08B) and placing the variable name directly after the `SYS 53387` command.  After calling, registers A/X will contain the address in the variable descriptor just past the two letter variable name.  The address is stored as an LSB/MSB pair and we can access registers A/X through locations 780/781 in memory.

## Getting Integer Address

The following program uses the _EVLVAR_ routine at 53387 to get an address in the variable descriptor for the variable `N%`.  `D` will contain the address of the 16-bit integer, stored in MSB/LSB order.  This address is then used to get the integer and put it in `V`.  The program prints the bytes of the variable descriptor and the value of the variable.

```
10 N%=312
20 SYS 53387N%
30 D=PEEK(780)+256*PEEK(781)
40 V=256*PEEK(D)+PEEK(D+1)

100 PRINT "VARIABLE DESCRIPTOR:"
110 FOR I=-2TO4
120 PRINT PEEK(D+I);
130 NEXT I
140 PRINT

200 PRINT "INTEGER VALUE:"
210 PRINT V
```

The variable descriptor for `N%` looks like the following.  Char1 and Char2 are for the two letter variable name with 128 added to each letter to indicate that it is an integer.  In the BASIC program above `D` points to the MSB of the integer value.

<table class="neatTable neatBorder">
  <tr><th>Char1<br/>+128</th><th>Char2<br />+128</th><th>MSB</th><th>LSB</th><th>0</th><th>0</th><th>0</th></tr>
  <tr><td>206</td><td>128</td><td>1</td><td>56</td><td>0</td><td>0</td><td>0</td></tr>
</table>


## Get String Address

Getting the address of a string is very similar to getting that of an integer.    `D` will again contain an address in the variable descriptor, however it now points to the length of the string which is stored in `L` and is followed by an address, which is stored in `P`, which points to the actual string.  The program prints the bytes of the variable descriptor and the string.  There is a small bug that will prevent this being used with the `E$` variable.  It is possible to overcome this bug with other routines to handle parenthesis around it but I think that it's probably easier to just use another variable name.


```
10 N$="FRED"
20 SYS 53387N$
30 D=PEEK(780)+256*PEEK(781)
40 L=PEEK(D)
50 P=PEEK(D+1)+256*PEEK(D+2)

100 PRINT "VARIABLE DESCRIPTOR:"
110 FOR I=-2TO4
120 PRINT PEEK(D+I);
130 NEXT I
140 PRINT

200 PRINT "STRING VALUE:"
210 FOR I=0 TO L-1
220 PRINT CHR$(PEEK(P+I));
230 NEXT I
```

The variable descriptor for `N$` looks like the following.  Char1 and Char2 are for the two letter variable name with 128 added to Char2 to indicate that it is a string.  In the BASIC program above `D` points to the length of the string.  The string length is then followed by a pointer to the string.

<table class="neatTable neatBorder">
  <tr><th>Char 1<br/>+0</th><th>Char 2<br />+128</th><th>Length</th><th>Pointer<br/>LSB MSB</th><th>0</th><th>0</th></tr>
  <tr><td>78</td><td>128</td><td>4</td><td>4105</td><td>0</td><td>0</td></tr>
</table>


## Getting Variable Address with Assembly Language

From assembly language we can call the _FNDVAR_ routine at $D0E7 (53479).  This routine expects the name of the variable to search for to be in $45/$46 (69/70) with 128 added as needed to indicate the type of the variable.  The address in the variable descriptor just past the name will be returned at $47/$48 (71/72), in LSB/MSB order.

The examples uses [VICMON](/articles/programming-in-assembly-with-vicmon-on-the-vic-20/ "TechTinkering article: Programming in Assembly with VICMON on the VIC-20"), which we start with:

```
SYS 24576
```

Enter the following routine at $02A1 (673) to get the address of the value of variable `N%` and print it to screen.  The routine uses the _PRTFIX_ routine at $DDCD (56781) to print the integer value of the variable.  I have added comments but ignore these if entering into VICMON.

```
.E1500                       ; Enable virtual zero page
.A 02A1 LDA #$CE             ; Variable letter 'N' + 128
.A 02A3 STA $45              ; Store first letter of variable
.A 02A5 LDA #$80             ; Blank variable letter + 128
.A 02A7 STA $46              ; Store second letter of variable
.A 02A9 JSR $D0E7            ; Call FNDVAR to get address
.A 02AC LDY #$01
.A 02AE LDA ($47), Y
.A 02B0 TAX                  ; Put LSB of integer in X
.A 02B1 DEY
.A 02B2 LDA ($47), Y         ; Put MSB of integer in A
.A 02B4 JSR $DDCD            ; Call PRTFIX to printer integer in A/X
.A 02B7 RTS
.X                           ; Exit VICMON and return to BASIC
```

Initialize the variable `N%` with the value `312` and call the routine we created to print the value of `N%`.
```
10 N%=312
20 SYS 673
```


## Floating Point, Function Descriptor and Array Variables

There is probably less need to get the address of floating point, function descriptor and array variables.  These are more complicated and are therefore more difficult to access.  However, if their address is needed their storage is explained in detail in [Mapping the Vic, pp. 308-312](https://archive.org/details/COMPUTEs_Mapping_the_VIC_1984_COMPUTE_Publications/page/n329/mode/2up).



## Video

The following video shows these methods for getting the address of a variable in action.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/le8JVHxPsow" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
