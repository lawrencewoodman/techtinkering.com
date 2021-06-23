Saving and loading memory is quite easy on the VIC-20 once you know how.  However, it isn't obvious how to do this and therefore this article will present a few simple ways of doing it from BASIC and Assembler.

## Saving/Loading from BASIC a Byte at a Time

A straight forward way to save and load memory from BASIC is to use the `OPEN`, `PRINT#` and `GET#` commands to write or read a byte at a time.

### Saving

In the following file we are saving memory at _673-692_ to '_FLASH.PRG_' on device 8.  If we wanted to save it to a .SEQ file then we would use `FLASH,S,W`.  We use `CHR$` to convert the byte to PETSCII which the `PRINT#` command will then convert back to its byte representation when writing to the file.  One interesting thing to note is that even though this is saving to a .PRG file it doesn't save the load address.  If we want this included in the file then we need to start it with two bytes representing the LSB/MSB of the load address.

```
10 OPEN 8,8,1,"FLASH,W"
20 FOR I=673 TO 692
30 B=PEEK(I)
40 PRINT#8, CHR$(B);
50 NEXT I
60 CLOSE 8
```

### Loading

The following program will load '_FLASH.PRG_' into locations 673-692 from device 8. 

```
10 OPEN 8,8,0,"FLASH"
20 FOR I=673 TO 692
30 GET#8, B$
40 POKE I,ASC(B$)
50 NEXT I
60 CLOSE 8
```


If the file contains the origin address as the first two bytes then we can use that if desired.  We have to be careful that the origin address isn't where our tokenized basic program is being stored.  This allows us to load a memory block without corrupting a running BASIC program.  In the following `ST` is the status after certain I/O operations and is used here to detect the end of file by checking if it is equal to 64.

```
10 OPEN 8,8,0,"FLASH,R"
20 GET#8, O1$
30 GET#8, O2$
40 O=ASC(O1$)+256*ASC(O2$)
50 PRINT "ORIGIN: ";O
60 GET#8, B$
70 IF ST<>0 AND ST<>64 GOTO 200
80 POKE O,ASC(B$)
90 O=O+1
100 IF ST<>64 GOTO 60
110 CLOSE 8
120 END
200 PRINT "ERROR STATUS: ";ST
210 CLOSE 8
```

## Using the SAVE/LOAD Commands in BASIC

BASIC has built-in commands to save and load programs which we can use to save and load our block of memory.

## Saving

We can use the `SAVE` command in BASIC to save a block of memory by telling the Vic that the tokenized BASIC area is located at the same block of memory that we want to save.

The following example saves a block of memory at 673-692 to '_FLASH.PRG_' on cassette (device 1).   The start address is stored at 43/44 ($2B/2C) which indicates the start of tokenized BASIC in LSB/MSB order.  The end address is stored at 45/56 ($2D/$2E) which indicates the end of tokenized BASIC in LSB/MSB order.

``` basic
POKE 44,673/256:POKE 43,673-256*PEEK(44)
POKE 46,692/256:POKE 45,692-256*PEEK(46)
SAVE "FLASH",1,1
```

This works well but because it alters the BASIC start and end points it can't be used from within a BASIC program.  We should reset the Vic or restore these locations to their original values once finished.  It should also be noted that this method saves the load/origin address to the first two bytes of the file because the final `,1` is at the end of the `SAVE` command.  On cassette this prevents the relocate function of the `LOAD` command but doesn't apply to disk.

### Loading

If we have saved a block of memory that had a start address and is a self-contained runnable program then we can simply use:

```
LOAD "FLASH",8,1
```


## SYS to BASIC/KERNEL ROM from BASIC

We can call BASIC/KERNEL ROM routines from BASIC using `SYS` to save and load blocks of memory in a way which will work within a BASIC program.  This method uses the BASIC ROM routine _PARSL_ at 57809 ($E1D1) which sets the LOAD, VERIFY and SAVE parameters and therefore is designed to process the rest of the parameters after it is called.  In this case `(N$),<device>`.  Locations 780, 781 and 782 are used to access the 6502 registers: A, X, Y.

From: [ROM Calls and Other Tricks on the Denial Forum](https://sleepingelephant.com/ipw-web/bulletin/bb/viewtopic.php?f=2&t=676&start=15&fbclid=IwAR3H8vVeiqckY-QcqzTRRJzLAKKA1PeKpucrHHvW7w8xCgvGf7RympzfAME#p75231)

### Saving

The following method saves memory to the filename in `N$`.  _end_ must be one past the address of the last byte to save.  This routine uses the KERNEL ROM routine _SAVE_ at 65496 ($FFD8) to perform the save.  It uses register A (location 780) to set the starting address store to 193.

```
N$="FLASH"
SYS57809(N$),<device>:POKE193,<start_lo>:POKE194,<start_hi>
POKE780,193:POKE781,<end_lo>:POKE782,<end_hi>:SYS65496
```

If we wanted to save the memory at 673-692 ($02A1-$02B4) to '_FLASH.PRG_' on device '8' and store the load address using `,1` it would look like the following.  The final `,1` after the device isn't actually used by disk but we may want to use it if saving to cassette (device 1).  We can also replace `(NS)` with the quoted filename:


```
SYS57809"FLASH",8,1:POKE193,161:POKE194,2
POKE780,193:POKE781,181:POKE782,2:SYS65496
```

### Loading

Loading is equally easy and in this case uses the KERNEL ROM routine _LOAD_ at 65493 ($FFD5) to perform the load.  If `,1` after device then it is forced to load at original address and pokes for `start_lo` and `start_hi` aren't needed.  Register A (location 780) is used to specify a LOAD (0) operation rather than a VERIFY (1) operation.

```
N$="FLASH"
SYS57809(N$),<device>:POKE780,0:POKE781,<start_lo>:POKE782,<start_hi>:SYS65493
```

Therefore if we want to load our '_FLASH.PRG_' program, saved previously, we can use the following to load it from device 8 into its original memory location:

```
SYS57809"FLASH",8,1:POKE780,0:SYS65493
```


## Assembly Routines for Saving and Loading

We can use some of the same routines used by the SYS calls above to load and save memory from assembly.  We first have to set up the device, file number and secondary address using the _SETLFS_ routine at $FFBA (65466) and then use the _SETNAM_ routine at $FFBD (65469) to set the filename.  Finally we call either the _LOAD_ or _SAVE_ routine after setting the start and end addresses appropriately of the memory block to load or save.

### Saving


The following routine would save block-blockend from memory to the file '_FLASH.PRG_' on drive 8.  The secondary address has no effect when being saved to disk but has the same effect as the BASIC `SAVE` command if saving to cassette.  It uses the same _SAVE_ routine at $FFD8 (65496) used above.

```
; KERNEL/BASIC ROM Routines
SAVE        = $FFD8
SETLFS      = $FFBA
SETNAM      = $FFBD

            LDA  #$08            ; Logical file number
            LDX  #$08            ; Device number
            LDY  #$01            ; Secondary address
            JSR  SETLFS          ; Set above parameters

            LDA  #$05            ; Length of file name
            LDX  #<filename      ; Low byte of file name location
            LDY  #>filename      ; High byte of file name location
            JSR  SETNAM          ; Set the name

            LDA  #<block         ; Low byte of start of memory block
            STA  $C1
            LDA  #>block         ; High byte of start of memory block
            STA  $C2

            LDA  #$C1            ; Pointer to location of start address
            LDX  #<(blockend+1)  ; Low byte of (end of memory block + 1)
            LDY  #>(blockend+1)  ; High byte of (end of memory block + 1)
            JSR  SAVE            ; Perform save
            BCS  error           ; Jump to error handler if error

            RTS

error       ; Handle error in A
            RTS

filename    .asc "FLASH"

            ; The two byte memory block to save
block       .byt $05
blockend    .byt $06
```


### Loading


The following routine would load the file '_FLASH.PRG_' from drive 8 to memory at location 673 ($02A1).  It uses the same _LOAD_ routine at $FFD5 (65493) used above.

```
block       = $02A1              ; Load address

; KERNEL/BASIC ROM Routines
LOAD        = $FFD5
SETLFS      = $FFBA
SETNAM      = $FFBD

main        LDA  #$08            ; Logical file number
            LDX  #$08            ; Device number
            LDY  #$00            ; Secondary address
                                 ; $00 Load using specifed address
                                 ; $01 Load using original address from file
            JSR  SETLFS          ; Set above parameters

            LDA  #$05            ; Length of file name
            LDX  #<filename      ; Low byte of file name location
            LDY  #>filename      ; High byte of file name location
            JSR  SETNAM          ; Set the name

            LDA  #$00            ; Load = 0, Verify = 1
            LDX  #<block         ; Low byte of start address
            LDY  #>block         ; High byte of start address
            JSR  LOAD            ; Perform load
            BCS  error           ; Jump to error handler if error

            RTS

error       ; Handle error in A
            RTS

filename    .asc "FLASH"
```


## Machine Language Monitors

To finish this off the last method I want to mention is loading and saving via a machine language monitor such as [VICMON](/articles/programming-in-assembly-with-vicmon-on-the-vic-20/ "TechTinkering article: Programming in Assembly with VICMON on the VIC-20").

### Saving

We can save in VICMON using the _S_ command.  The following example saves the memory at 673-692 ($02A1-$02B4) to '_FLASH.PRG_' on device '8'.  Note that we are using `02B5` as the end address because the end address for this command has to be one past the last byte that we want to save.  The .PRG file will be stored with its origin  address.

```
.S "FLASH",08,02A1,02B5
```


### Loading

To load a file we use the _L_ command which takes an optional device number. If the device number isn't specified then it defaults to 01 - the cassette.  In the following example we are loading '_FLASH.PRG_' from device 8 into the same memory location that it was saved from.

```
.L "FLASH",08
```

## Video

The following video shows these methods of saving and loading memory in action.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/sOBrRV6p82w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
