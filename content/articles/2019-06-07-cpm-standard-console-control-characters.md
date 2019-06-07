CP/M helped provide a consistent console interface for the user by supporting a number of standard control characters through the BDOS console functions.  This was great for the user and made life much easier for the programmer as a lot of the work was already done for them.

## CP/M 2.2 Control Characters

<table class="neatTable neatBorder">
  <tr><th>Character</th><th>Meaning</th></tr>
  </tr>
    <td>CTRL-C</td>
    <td>Restart (warm boot) system.  This is used to exit a running program and to reset the disk system.  On CP/M 2.2 you use this at the system prompt after changing a diskette to allow you write to it without corrupting the disk.</td>
  </tr>
  </tr>
    <td>CTRL-E</td>
    <td>Move cursor to beginning of next line without sending line to be processed.  This is useful for typing long lines that are longer than the terminal's line length.</td>
  </tr>
  <tr>
    <td>CTRL-H,<br />RUBOUT,<br />DELETE</td>
    <td>Delete character to the left of cursor.  On some terminals this will repeat the character deleted on others it will move the cursor one character to the left.</td>
  <tr>
    <td>CTRL-I,<br />TAB</td>
    <td>Move cursor to next tap stop which is automatically set at each  column.</td>
  </tr>
  <tr>
    <td>CTRL-J,<br />CTRL-M,<br />RETURN</td>
    <td>Send the line to be processed and move the cursor to the beginning of a new line below.</td>
  </tr>
  </tr>
    <td>CTRL-P</td>
    <td>Start echoing everything sent to the console to the printer.  A second CTRL-P stops printer echo.</td>
  </tr>
  <tr>
    <td>CTRL-R</td>
    <td>Re-type current line.  It will place a '#' at the end of the current line and then redisplay the current line below.  This is useful if you have been deleting characters in a line or the line has got corrupted for some reason.</td>
  </tr>
  <tr>
    <td>CTRL-S</td>
    <td>Stop terminal from scrolling.  This is useful if text is scrolling too fast on the terminal to read it.  If the scrolling is paused you can terminate the program with CTRL-C.  A second CTRL-S allows terminal to start scrolling again.</td>
  </tr>
  <tr>
    <td>CTRL-U</td>
    <td>Discard line and allows you to start again on the line below.  It will place a '#' at the end of the discarded line and then move to the beginning of the next line to allow you to enter replacement text.</td>
  </tr>
  <tr>
    <td>CTRL-X</td>
    <td>Erase line and move the cursor to the beginning of that line.</td>
  </tr>
</table>

<div class="youtube-wrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/TVOnK6b5plo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## CP/M 3 Control Characters

CP/M 3 added a number of control characters and changed others.

<table class="neatTable neatBorder">
  <tr><th>Character</th><th>Meaning</th></tr>
  <tr>
    <td>CTRL-Q</td>
    <td>Restart terminal scrolling after being stopped with CTRL-S.</td>
  </tr>
  <tr>
    <td>CTRL-R</td>
    <td>Re-type current line.  It will place a '#' at the <em>current cursor position and display the current line left of the cursor on the line below.  This is useful if you have been editing a line</em> or the line has got corrupted for some reason.</td>
  </tr>
  <tr>
    <td>CTRL-S</td>
    <td>Stop terminal from scrolling.  This is useful if text is scrolling too fast on the terminal to read it.  If the scrolling is paused you can terminate the program with CTRL-C.  <em>CTRL-Q allows terminal to start scrolling again.</em></td>
  </tr>
  <tr>
    <td>CTRL-X</td>
    <td>Erase line <em>to the left of the cursor and move the cursor to the beginning of that line.  This keeps any characters to the right of the cursor.</em></td>
  </tr>
</table>

### CP/M 3 Line Editing Control Characters

One of the great additions in CP/M 3 is the line editing control characters that provide a standard way to edit a line.  This only worked on systems that were configured for banked memory, but by the time CP/M 3 came out most new machines were.

<table class="neatTable neatBorder">
  <tr><th>Character</th><th>Meaning</th></tr>
  <tr>
    <td>CTRL-A</td>
    <td>Move the cursor one character to the left.</td>
  </tr>
  <tr>
    <td>CTRL-B</td>
    <td>Move the cursor to the beginning of the line.  If the cursor is beginning of the line then it moves the cursor to the end of the line.</td>
  </tr>
  <tr>
    <td>CTRL-F</td>
    <td>Move the cursor one character to the right.</td>
  </tr>
  <tr>
    <td>CTRL-G</td>
    <td>Delete the character at the cursor.  The rest of the line to the right of the cursor moves one character to the left.</td>
  </tr>
  <tr>
    <td>CTRL-I,<br />TAB</td>
    <td>Move cursor to next tap stop which is automatically set at each eighth column.  <em>If there is text to the right of the cursor it will be moved to the next tab stop.</em></td>
  </tr>
  <tr>
    <td>CTRL-K</td>
    <td>Delete from the cursor to the end of the line.</td>
  </tr>
  <tr>
    <td>CTRL-W</td>
    <td>Recall previous line discarded that was to the left of the cursor when CTRL-U was pressed.</td>
  </tr>
</table>

<div class="youtube-wrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/cgyIpAkcFyA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## Test Programs

To demonstrate that these control characters were handled by the built-in BDOS calls, two programs are supplied below.

### Testing Line Input Control Characters
The following program repeatedly accepts a line of text and then when 'RETURN' or similar is pressed it will echo it back to the user.  It demonstrates how the built-in BDOS 10 (`RBUFF`) function, called from within `CIMSG`, handles the standard console input control characters for the programmer.

```` NASM
; ECHO LINES OF TEXT ENTERED
; BASED ON EXAMPLE FROM CP/M ASSEMBLY LANGUAGE PROGRAMMING BY KEN BARBIER
; 4 JUNE 2019

; ASCII CHARACTERS
CR      EQU     0DH             ; CARRIAGE RETURN
LF      EQU     0AH             ; LINE FEED

; CP/M BDOS FUNCTIONS
WCONF   EQU     2               ; WRITE (E) TO CON:
RBUFF   EQU     10              ; READ A CONSOLE LINE

; CP/M ADDRESSES
BDOS    EQU     5               ; SYSTEM CALL ENTRY
TPA     EQU     100H            ; TRANSIENT PROGRAM AREA

        ORG     TPA

START:  LXI     SP,STAK         ; SET UP USER'S STACK
START2: CALL    CIMSG           ; GET A LINE OF INPUT
        CALL    CCRLF
        LXI     H,INBUF+2       ; POINT TO ITS TEXT
        CALL    COMSG           ; ECHO THE WHOLE LINE
        CALL    CCRLF           ; AND CR, LF
        JMP     START2          ; THEN DO ANOTHER

; CHARACTER IN REGISTER A OUTPUT TO CONSOLE
CO:     PUSH    B               ; SAVE REGISTERS
        PUSH    D
        PUSH    H
        MVI     C,WCONF         ; SELECT FUNCTION
        MOV     E,A             ; CHARACTER TO E
        CALL    BDOS            ; OUTPUT BY CP/M
        POP     H               ; RESTORE REGISTERS
        POP     D
        POP     B
        RET

; CARRIAGE RETURN, LINE FEED TO CONSOLE
CCRLF:  MVI     A,CR
        CALL    CO
        MVI     A,LF
        JMP     CO

; MESSAGE POINTED TO BY HL OUT TO CONSOLE
COMSG:  MOV     A,M             ; GET A CHARACTER
        ORA     A               ; ZERO IS THE TERMINATOR
        RZ                      ; RETURN ON ZERO
        CALL    CO              ; ELSE OUTPUT THE CHARACTER
        INX     H               ; POINT TO THE NEXT ONE
        JMP     COMSG           ; AND CONTINUE

; INPUT CONSOLE MESSAGE INTO BUFFER
CIMSG:  PUSH    B               ; SAVE REGISTERS
        PUSH    D
        PUSH    H
        LXI     H,INBUF+1       ; ZERO CHARACTER COUNTER
        MVI     M,0
        DCX     H               ; SET MAXIMUM LINE LENGTH
        MVI     M,80
        XCHG                    ; INBUF POINTER TO DE REGISTERS
        MVI     C,RBUFF         ; SET UP READ BUFFER FUNCTION
        CALL    BDOS            ; INPUT A LINE
        LXI     H,INBUF+1       ; GET CHARACTER COUNTER
        MOV     E,M             ; INTO LSB OF DE REGISTER PAIR
        MVI     D,0             ; ZERO MSB
        DAD     D               ; ADD LENGTH TO START
        INX     H               ; PLUS ONE POINTS TO END
        MVI     M,0             ; INSERT TERMINATOR AT END
        POP     H               ; RESTORE ALL REGISTERS
        POP     D
        POP     B
        RET

INBUF:  DS      83              ; LINE INPUT BUFFER

; SET UP STACK SPACE
        DS      64              ; NUM LOCATIONS ON STACK
STAK    DB      0               ; TOP OF STACK

        END
````

### Testing Output Control Characters

The program below will output alternating '0' or '1' characters which you can pause/unpause with 'CTRL-S' and 'CTRL-Q' as appropriate.  If paused you can exit the program with 'CTRL-C'.  The standard console output control characters are handled by the built-in BDOS 2 (`WCONF`) function which relieves the programmer of this task.

```` NASM
; OUTPUT ALTERNATE '0' OR '1' CHARACTERS
; BY LAWRENCE WOODMAN
; 4 JUNE 2019

; CP/M BDOS FUNCTIONS
WCONF   EQU     2               ; WRITE (E) TO CON:

; CP/M ADDRESSES
BDOS    EQU     5
TPA     EQU     100H

        ORG     TPA

START:  MVI     C,WCONF
        MVI     E,'0'
        CALL    BDOS
        MVI     C,WCONF
        MVI     E,'1'
        CALL    BDOS
        JMP     START

        END
````
