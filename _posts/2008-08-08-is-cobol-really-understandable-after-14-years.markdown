---
layout: article
title: Is COBOL really understandable after 14 years?
tags:
  - Programming
  - Cobol
  - Retro
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
COBOL has been in the news quite a lot recently and I have been reading that there are still huge amounts of COBOL code running and being written.  This led me to wonder why this language was still being used.  I therefore decided to look at a few sites about COBOL and see what they said was good about the language.  The main benefits appeared to be that it is portable and self-documenting.  Indeed, I often read about how COBOL programmers say that they can go to code written 10-15 years ago and still easily understand what is happening.

In 1994, while at college, I did a year of COBOL.  I haven't touched it since that time, and have barely even thought about it.  I therefore thought that this would be a good test.  I admit that the premise above, about the ease of understanding code written a long time ago, refers to people with more COBOL experience than I.  However, I was curious to see how much I would understand.

The code I have chosen was originally written to run under MS-DOS, but unfortunately I can't remember which compiler was used.  It probably isn't the best COBOL code ever written, but I hope that it will help me to explore how easy it is to return to old code.  At times throughout this article I may well refer to things by the wrong name, please bear in mind that the purpose of the article is to test the premise "Is COBOL really understandable after 14 years?", not to teach COBOL.

I have put the full code, associated data file, example output and instructions on how to compile and run the program at the bottom of this article.

## Analysis of the code
After taking a quick look at the code I remember that COBOL is split into DIVISIONs, SECTIONs and paragraphs.  I will go through each DIVISION in turn and try to explain what is happening.  I have purposely not looked up anything while doing this to try and test the premise fully.

### The IDENTIFICATION DIVISION
This is fairly unremarkable and is just used to identify what the code is and who wrote it.
{% highlight text %}
IDENTIFICATION DIVISION.
PROGRAM-ID. ASSIGN1.
AUTHOR. xxxxxxxxxx
* Assignment 1 for COBOL.
{% endhighlight %}

### The ENVIRONMENT DIVISION
This DIVISION is used to specify the environment in which the code will run.  The power of this DIVISION is that you can easily change the environment in which the program is running just by making alterations here.

{% highlight text %}
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
SELECT TAG2-FILE ASSIGN TO "TAG2.DAT".
SELECT REP-FILE ASSIGN TO "PRN".
{% endhighlight %}

Within the above DIVISION we can see the INPUT-OUTPUT SECTION and within that we can see the FILE-CONTROL paragraph.  This is telling the program what names to use to refer to the files and what those files are called.  I can see from this that we have a file called TAG2.DAT and another called PRN.  Under MS-DOS, PRN referred to the printer.  However when this is run under Linux it will just create a file called PRN. 

### The DATA DIVISION
This DIVISION specifies how data is stored and structured.

{% highlight text %}
DATA DIVISION.
FILE SECTION.
FD TAG2-FILE.
01 TAG2-RCD.
  03 TAG2-ORD-NBR  PIC 9(4).
  03 TAG2-ACC-NBR  PIC A9(7)A.
  03 TAG2-COLOUR   PIC A(3).
  03 TAG2-PRN      PIC A(2).
  03 TAG2-QTY      PIC 9(2).
  03 TAG2-TAG      PIC A(20).
  03 TAG2-DATE     PIC X(6).

FD REP-FILE.
01 REP-RCD.
  03 REP-ACC-NBR   PIC A9(7)A.
  03 FILLER        PIC X(7)       VALUE SPACES.
  03 REP-TAG       PIC A(20).
  03 FILLER        PIC X(9)       VALUE SPACES.
  03 REP-PRN       PIC AA.
  03 FILLER        PIC X(6)       VALUE SPACES.
  03 REP-QTY       PIC Z9.
  03 FILLER        PIC X(6)       VALUE SPACES.
{% endhighlight %}

The first SECTION here is the FILE SECTION, which is specifying how the files assigned in the ENVIRONMENT DIVISION to TAG2-FILE and REP-FILE are structured.

If we take TAG2-FILE we can see that it's biggest structure is TAG2-RCD which is representing a record.  This record is split into 7 fields.  The PIC statements after the names of the field specify the format of the field.  For TAG2-ORD-NBR this is 9(4) representing 4 numeric characters.  For TAG2-ACC-NBR this is A9(7)A representing an alphabetical character then 7 numeric characters then an alphabetical character.  Finally TAG2-DAT has X(6) representing 6 characters of any type.

{% highlight text %}
WORKING-STORAGE SECTION.
   01 WS1-AREA.
      03 WS1-LCNT  PIC 99 VALUE 70.

      03 WS1-DATE.
         05 WS1-YR   PIC XX.
         05 WS1-MT   PIC XX.
         05 WS1-DY   PIC XX.

      03 WS1-HDR-AREA.
         05 WS1-DAY       PIC XX.
         05 FILLER        PIC X VALUE '/'.
         05 WS1-MTH       PIC XX.
         05 FILLER        PIC X VALUE '/'.
         05 WS1-YER       PIC XX.
         05 FILLER        PIC X(10) VALUE SPACES.
         05 FILLER        PIC X(19) VALUE 'NAME TAG REPORT - 2'.
         05 FILLER        PIC X(15) VALUE SPACES.
         05 FILLER        PIC X(4)  VALUE 'PAGE'.
         05 FILLER        PIC X(1)  VALUE SPACES.
         05 WS1-PAGE-NBR  PIC Z9.

     03 WS1-PAGE-EDIT    PIC 99 VALUE 0.

     03 WS1-SUB-HDR.
        05 FILLER        PIC X(19) VALUE SPACES.
        05 FILLER        PIC X(9)  VALUE 'COLOUR - '.
        05 SUB-COLOUR    PIC X(5)  VALUE SPACES.

     03 WS1-SUB-HDR2.
        05 FILLER        PIC X(9)  VALUE 'Acct.Nbr.'.
        05 FILLER        PIC X(7)  VALUE SPACES.
        05 FILLER        PIC X(11) VALUE 'Name on Tag'.
        05 FILLER        PIC X(18) VALUE SPACES.
        05 FILLER        PIC X(4)  VALUE 'Type'.
        05 FILLER        PIC X(4)  VALUE SPACES.
        05 FILLER        PIC X(4)  VALUE 'Qty.'.

     03 WS1-COLOR-CHECK PIC A(3)   VALUE SPACES.

     03 WS1-RESULT1.
        05 FILLER        PIC X(5)  VALUE SPACES.
        05 FILLER        PIC X(23) VALUE
                              'RED.........QUANTITY - '.
        05 WS1-RED-TOTAL PIC ZZZ9.
        05 FILLER        PIC X(7)  VALUE SPACES.
        05 FILLER        PIC X(4)  VALUE 'COST'.
        05 FILLER        PIC X     VALUE SPACE.
        05 WS1-RED-COST  PIC $$$$9.99.

     03 WS1-RESULT2.
        05 FILLER        PIC X(5)  VALUE SPACES.
        05 FILLER        PIC X(23) VALUE
                              'BLUE........QUANTITY - '.
        05 WS1-BLU-TOTAL PIC ZZZ9.
        05 FILLER        PIC X(7)  VALUE SPACES.
        05 FILLER        PIC X(4)  VALUE 'COST'.
        05 FILLER        PIC X     VALUE SPACE.
        05 WS1-BLU-COST  PIC $$$$9.99.

     03 WS1-RESULT3.
        05 FILLER        PIC X(5)  VALUE SPACES.
        05 FILLER        PIC X(23) VALUE
                              'BLACK.......QUANTITY - '.
        05 WS1-BLA-TOTAL PIC ZZZ9.
        05 FILLER        PIC X(7)  VALUE SPACES.
        05 FILLER        PIC X(4)  VALUE 'COST'.
        05 FILLER        PIC X     VALUE SPACE.
        05 WS1-BLA-COST  PIC $$$$9.99.

     03 RESULT-CALC.
        05 WS1-BLU-ADD   PIC 9999 VALUE 0.
        05 WS1-RED-ADD   PIC 9999 VALUE 0.
        05 WS1-BLA-ADD   PIC 9999 VALUE 0.
        05 WS1-BLU-TOT   PIC 9(5)V99 VALUE 0.
        05 WS1-RED-TOT   PIC 9(5)V99 VALUE 0.
        05 WS1-BLA-TOT   PIC 9(5)V99 VALUE 0.

     03 WS1-CONTROL-HDR.
        05 FILLER        PIC X(19) VALUE SPACES.
        05 FILLER        PIC X(9)  VALUE 'CONTROLS'.
        05 FILLER        PIC X(4)  VALUE SPACES.
{% endhighlight %}

The next section is the WORKING-STORAGE SECTION.  This is where the variables are specified.  The variables are set out in the same way as the files.  If we look at RESULT-CALC we can see that it is made up of 6 fields each with an initial value of 0.  The V used in the last 3 PIC statements represents a decimal point.

The variables can be referred to by any of the names specified above and will include each of the subdivisions of that name.  So you can refer to RESULT-CALC and it will also automatically be referring to each of its fields as well, or you can just refer to the fields directly e.g. WS1-BLU-ADD.  There is no need to refer to the fields by way of the record.  Which does mean that you have to be careful about not reusing names.


### The PROCEDURE DIVISION
This is the DIVISION where all the processing gets done.  It can be split into SECTIONs so that you can have subroutines.  However, this piece of code doesn't have any SECTIONs within the PROCEDURE DIVISION.

{% highlight text %}
PROCEDURE DIVISION.
     OPEN INPUT TAG2-FILE.
     OPEN OUTPUT REP-FILE.

* Get the Date
     ACCEPT WS1-DATE FROM DATE.
     MOVE WS1-YR TO WS1-YER.
     MOVE WS1-MT TO WS1-MTH.
     MOVE WS1-DY TO WS1-DAY.
{% endhighlight %}
This is opening the files mentioned earlier for INPUT and OUTPUT.  Then today's date is put into WS1-DATE.  After that, the fields in WS1-DATE are specified directly, e.g. WS1-YR.  These fields are moved into fields from WS1-HDR-AREA, e.g. WS1-YER.  Note the Y2K problem here as it is only using a 6 byte date.

{% highlight text %}
A01-OP-LINE.
   READ TAG2-FILE AT END GO TO A90-END.
{% endhighlight %}
A01-OP-LINE is a paragraph label that is used to form a loop.  The next line reads a record from TAG2-FILE and if the end of file is reached it jumps to the paragraph A90-END.
{% highlight text %}
* Put Correct Colour Name in Sub Heading
     IF TAG2-COLOUR = 'BLU'
     THEN MOVE SPACES TO SUB-COLOUR
          MOVE 'BLUE' TO SUB-COLOUR
     ELSE IF TAG2-COLOUR = 'RED'
          THEN MOVE SPACES TO SUB-COLOUR
               MOVE 'RED' TO SUB-COLOUR
          ELSE MOVE SPACES TO SUB-COLOUR
               MOVE 'BLACK' TO SUB-COLOUR.
{% endhighlight %}
This puts the colour of the tag record read in from the TAG2-FILE into SUB-COLOUR which is a field of WS1-SUB-HDR.
{% highlight text %}
* If the number of lines printed > 57 then put up the page heading
     IF WS1-LCNT > 57
     THEN ADD 1 TO WS1-PAGE-EDIT
          MOVE "  " TO WS1-PAGE-NBR
          MOVE WS1-PAGE-EDIT TO WS1-PAGE-NBR
          WRITE REP-RCD FROM WS1-HDR-AREA AFTER ADVANCING PAGE
          MOVE ZERO TO WS1-LCNT
* Output Colour Sub Heading
          MOVE SPACES TO WS1-COLOR-CHECK
          MOVE TAG2-COLOUR TO WS1-COLOR-CHECK
          WRITE REP-RCD FROM WS1-SUB-HDR AFTER ADVANCING 3 LINES
          WRITE REP-RCD FROM WS1-SUB-HDR2 AFTER ADVANCING 1 LINE
          ADD 4 TO WS1-LCNT
          MOVE SPACES TO REP-RCD.
{% endhighlight %}
This prints a header for the page if more than 57 lines have been printed and also prints a heading for the current colour table.  WS1-LCNT is initialised with the value of 70 in the WORKING-STORAGE SECTION, so a header is printed on the first page.  The code if fairly self explanatory.  The MOVE statements copy the literal or variable being referred to into the variable specified.  SPACES represent a full field of space characters.  ZERO is the numerical literal 0.  WRITE REP-RCD... writes the record specified by FROM to the file REP-FILE which is associated with REP-RCD.  The THEN statement will execute everything up to the period, this is called a sentence.
{% highlight text %}
IF WS1-COLOR-CHECK = TAG2-COLOUR
THEN NEXT SENTENCE
ELSE MOVE SPACES TO WS1-COLOR-CHECK
    MOVE TAG2-COLOUR TO WS1-COLOR-CHECK
    WRITE REP-RCD FROM WS1-SUB-HDR AFTER ADVANCING 3 LINES
    WRITE REP-RCD FROM WS1-SUB-HDR2 AFTER ADVANCING 1 LINE
    ADD 4 TO WS1-LCNT
    MOVE SPACES TO REP-RCD.
{% endhighlight %}

This checks if the record just read from TAG2-FILE is a different colour from the current table colour.  If the colour is the same then it skips to the NEXT SENTENCE, i.e. after the period.  Otherwise it prints a heading for the table.  The AFTER ADVANCING 3 LINES outputs 3 newlines to the file before writing the record.
{% highlight text %}
MOVE TAG2-ACC-NBR TO REP-ACC-NBR.
MOVE TAG2-TAG TO REP-TAG.
MOVE TAG2-PRN TO REP-PRN.
MOVE TAG2-QTY TO REP-QTY.
WRITE REP-RCD AFTER ADVANCING 1 LINE.
{% endhighlight %}
This copies some of the fields of the record TAG2-RCD read in from TAG2-FILE to some of the fields of the record REP-RCD.  The REP-RCD record is then written to the associated REP-FILE.  If you look at REP-RCD in the FILE SECTION you will see that each field is seperated by FILLER spaces.  This is so that a neat table can be built for output.

{% highlight text %}
* Add up Tag Quantity for each Colour
     IF TAG2-COLOUR = 'BLU'
     THEN ADD TAG2-QTY TO WS1-BLU-ADD
     ELSE IF TAG2-COLOUR = 'RED'
          THEN ADD TAG2-QTY TO WS1-RED-ADD
          ELSE ADD TAG2-QTY TO WS1-BLA-ADD.
{% endhighlight %}

This determines which colour the current record is from TAG2-COLOUR, then adds the quantity of the current record to the relevant variable.  E.g. for the case of TAG2-COLOUR = 'BLU' the quantity TAG2-QTY is added to the variable WS1-BLU-ADD.
{% highlight text %}
* Add up Tag Cost for each Colour
     IF TAG2-COLOUR = 'BLU' AND TAG2-QTY = 24
     THEN ADD 2.25 TO WS1-BLU-TOT
     ELSE IF TAG2-COLOUR = 'BLU' AND TAG2-QTY = 36
          THEN ADD 3.00 TO WS1-BLU-TOT.

     IF TAG2-COLOUR = 'RED' AND TAG2-QTY = 24
     THEN ADD 2.25 TO WS1-RED-TOT
     ELSE IF TAG2-COLOUR = 'RED' AND TAG2-QTY = 36
          THEN ADD 3.00 TO WS1-RED-TOT.

     IF TAG2-COLOUR = 'BLA' AND TAG2-QTY = 24
     THEN ADD 2.25 TO WS1-BLA-TOT
     ELSE IF TAG2-COLOUR = 'BLA' AND TAG2-QTY = 36
          THEN ADD 3.00 TO WS1-BLA-TOT.
{% endhighlight %}              

This determines the cost to add to each colour's total.  There are a choice of two quantities than can be ordered.  Either 24 or 36.  It can be seen that here the code should be re-written to have the costs for each quantity stored as a variable for each colour.
{% highlight text %}
ADD 1 TO WS1-LCNT.
   GO TO A01-OP-LINE.
A90-END.
{% endhighlight %}

This adds 1 to the line count (WS1-LCNT).  Then jumps back to paragraph label A01-OP-LINE.  A90-END is a paragraph label which is used near the start of the code to jump to when the end of the file TAG2-FILE is reached.

{% highlight text %}
* Print Control Report
     MOVE WS1-BLU-ADD TO WS1-BLU-TOTAL.
     MOVE WS1-RED-ADD TO WS1-RED-TOTAL.
     MOVE WS1-BLA-ADD TO WS1-BLA-TOTAL.
     MOVE WS1-BLU-TOT TO WS1-BLU-COST.
     MOVE WS1-RED-TOT TO WS1-RED-COST.
     MOVE WS1-BLA-TOT TO WS1-BLA-COST.
     WRITE REP-RCD FROM WS1-CONTROL-HDR AFTER ADVANCING 4 LINES.
     WRITE REP-RCD FROM WS1-RESULT1 AFTER ADVANCING 1 LINE.
     WRITE REP-RCD FROM WS1-RESULT2 AFTER ADVANCING 1 LINE.
     WRITE REP-RCD FROM WS1-RESULT3 AFTER ADVANCING 1 LINE.
     CLOSE TAG2-FILE REP-FILE.
     STOP RUN.
{% endhighlight %}

The code finishes by copying the running cost and quantity totals to the fields in the records WS1-RESULT1, WS1-RESULT2, WS1-RESULT3.  Then writing a header to REP-FILE using WS-CONTROL-HDR, and writing the quantity and cost for each colour.  The files are then closed and the program is stopped.

## Summary of the program
The program reads in name tag records from TAG2.DAT and outputs a report to PRN.

## Conclusion
Once I had remembered how COBOL is set out, I found this program easy to understand and believe that it would be easy to maintain and expand.  I admit that this is only a trivial example, but then I haven't used COBOL for a long time, so I think it is a fair investigation.  I can see from the code why COBOL is so good at processing transactions and in particular batch processing.  A similar program written in Java, the new standard in the business world, would be considerably more complex and difficult to understand.  That said, I do recognise that while most of the added complexity would be with the code to read in the structured input file, the output report writing would be considerably easier by just using formatted strings. 

## Afterwards
After writing this article I decided to look at COBOL in more depth.  My main conclusion is that COBOL has advanced quite considerably since this code was written.  In fact I think that the style of COBOL we were taught in 1994 was already quite dated.  I have enjoyed this trip down memory lane, but now want to see if COBOL can offer anything for the present and into the future.  The most recent advance in COBOL appear to be an object orientated standard, which offers some considerable improvements while maintaining backwards compatibility.  Unfortunately the uptake on this seems to be slow.  COBOL does have a bad press, and after looking at modern COBOL, most of the complaints refer to problems that have been fixed over 30 years ago.  If COBOL is to halt its decline it needs more vocal advocates to show why it is so good and to help explain the COBOL mindset.  One further problem COBOL has long had is the lack of free compilers.  There are a couple of projects out there but they need support.  The most advanced project for Linux appears to be <a href="http://opencobol.org">OpenCOBOL</a>.  Another project which, though incomplete, should offer a great compiler in the long term is <a href="http://cobolforgcc.sourceforge.net/">Cobol for GCC</a>.  I wish these projects well, and hope that COBOL can regain the respect it deserves.
<hr />

## The full code (ASSIGN1.CBL)
{% highlight text %}
     IDENTIFICATION DIVISION.
     PROGRAM-ID. ASSIGN1.
     AUTHOR. Lawrence Woodman
    * Assignment 1 for COBOL.

     ENVIRONMENT DIVISION.
     INPUT-OUTPUT SECTION.
     FILE-CONTROL.
     SELECT TAG2-FILE ASSIGN TO "TAG2.DAT".
     SELECT REP-FILE ASSIGN TO "PRN".

     DATA DIVISION.
     FILE SECTION.
     FD TAG2-FILE.
     01 TAG2-RCD.
        03 TAG2-ORD-NBR  PIC 9(4).
        03 TAG2-ACC-NBR  PIC A9(7)A.
        03 TAG2-COLOUR   PIC A(3).
        03 TAG2-PRN      PIC A(2).
        03 TAG2-QTY      PIC 9(2).
        03 TAG2-TAG      PIC A(20).
        03 TAG2-DATE     PIC X(6).

     FD REP-FILE.
     01 REP-RCD.
        03 REP-ACC-NBR   PIC A9(7)A.
        03 FILLER        PIC X(7)       VALUE SPACES.
        03 REP-TAG       PIC A(20).
        03 FILLER        PIC X(9)       VALUE SPACES.
        03 REP-PRN       PIC AA.
        03 FILLER        PIC X(6)       VALUE SPACES.
        03 REP-QTY       PIC Z9.
        03 FILLER        PIC X(6)       VALUE SPACES.

      WORKING-STORAGE SECTION.
         01 WS1-AREA.
            03 WS1-LCNT  PIC 99 VALUE 70.

            03 WS1-DATE.
               05 WS1-YR   PIC XX.
               05 WS1-MT   PIC XX.
               05 WS1-DY   PIC XX.

            03 WS1-HDR-AREA.
               05 WS1-DAY       PIC XX.
               05 FILLER        PIC X VALUE '/'.
               05 WS1-MTH       PIC XX.
               05 FILLER        PIC X VALUE '/'.
               05 WS1-YER       PIC XX.
               05 FILLER        PIC X(10) VALUE SPACES.
               05 FILLER        PIC X(19) VALUE 'NAME TAG REPORT - 2'.
               05 FILLER        PIC X(15) VALUE SPACES.
               05 FILLER        PIC X(4)  VALUE 'PAGE'.
               05 FILLER        PIC X(1)  VALUE SPACES.
               05 WS1-PAGE-NBR  PIC Z9.

           03 WS1-PAGE-EDIT    PIC 99 VALUE 0.

           03 WS1-SUB-HDR.
              05 FILLER        PIC X(19) VALUE SPACES.
              05 FILLER        PIC X(9)  VALUE 'COLOUR - '.
              05 SUB-COLOUR    PIC X(5)  VALUE SPACES.

           03 WS1-SUB-HDR2.
              05 FILLER        PIC X(9)  VALUE 'Acct.Nbr.'.
              05 FILLER        PIC X(7)  VALUE SPACES.
              05 FILLER        PIC X(11) VALUE 'Name on Tag'.
              05 FILLER        PIC X(18) VALUE SPACES.
              05 FILLER        PIC X(4)  VALUE 'Type'.
              05 FILLER        PIC X(4)  VALUE SPACES.
              05 FILLER        PIC X(4)  VALUE 'Qty.'.

           03 WS1-COLOR-CHECK PIC A(3)   VALUE SPACES.

           03 WS1-RESULT1.
              05 FILLER        PIC X(5)  VALUE SPACES.
              05 FILLER        PIC X(23) VALUE
                                    'RED.........QUANTITY - '.
              05 WS1-RED-TOTAL PIC ZZZ9.
              05 FILLER        PIC X(7)  VALUE SPACES.
              05 FILLER        PIC X(4)  VALUE 'COST'.
              05 FILLER        PIC X     VALUE SPACE.
              05 WS1-RED-COST  PIC $$$$9.99.

           03 WS1-RESULT2.
              05 FILLER        PIC X(5)  VALUE SPACES.
              05 FILLER        PIC X(23) VALUE
                                    'BLUE........QUANTITY - '.
              05 WS1-BLU-TOTAL PIC ZZZ9.
              05 FILLER        PIC X(7)  VALUE SPACES.
              05 FILLER        PIC X(4)  VALUE 'COST'.
              05 FILLER        PIC X     VALUE SPACE.
              05 WS1-BLU-COST  PIC $$$$9.99.

           03 WS1-RESULT3.
              05 FILLER        PIC X(5)  VALUE SPACES.
              05 FILLER        PIC X(23) VALUE
                                    'BLACK.......QUANTITY - '.
              05 WS1-BLA-TOTAL PIC ZZZ9.
              05 FILLER        PIC X(7)  VALUE SPACES.
              05 FILLER        PIC X(4)  VALUE 'COST'.
              05 FILLER        PIC X     VALUE SPACE.
              05 WS1-BLA-COST  PIC $$$$9.99.

           03 RESULT-CALC.
              05 WS1-BLU-ADD   PIC 9999 VALUE 0.
              05 WS1-RED-ADD   PIC 9999 VALUE 0.
              05 WS1-BLA-ADD   PIC 9999 VALUE 0.
              05 WS1-BLU-TOT   PIC 9(5)V99 VALUE 0.
              05 WS1-RED-TOT   PIC 9(5)V99 VALUE 0.
              05 WS1-BLA-TOT   PIC 9(5)V99 VALUE 0.

           03 WS1-CONTROL-HDR.
              05 FILLER        PIC X(19) VALUE SPACES.
              05 FILLER        PIC X(9)  VALUE 'CONTROLS'.
              05 FILLER        PIC X(4)  VALUE SPACES.

     PROCEDURE DIVISION.
         OPEN INPUT TAG2-FILE.
         OPEN OUTPUT REP-FILE.

    * Get the Date
         ACCEPT WS1-DATE FROM DATE.
         MOVE WS1-YR TO WS1-YER.
         MOVE WS1-MT TO WS1-MTH.
         MOVE WS1-DY TO WS1-DAY.

     A01-OP-LINE.
         READ TAG2-FILE AT END GO TO A90-END.

    * Put Correct Colour Name in Sub Heading
         IF TAG2-COLOUR = 'BLU'
         THEN MOVE SPACES TO SUB-COLOUR
              MOVE 'BLUE' TO SUB-COLOUR
         ELSE IF TAG2-COLOUR = 'RED'
              THEN MOVE SPACES TO SUB-COLOUR
                   MOVE 'RED' TO SUB-COLOUR
              ELSE MOVE SPACES TO SUB-COLOUR
                   MOVE 'BLACK' TO SUB-COLOUR.

    * If the number of lines printed > 57 then put up the page heading
         IF WS1-LCNT > 57
         THEN ADD 1 TO WS1-PAGE-EDIT
              MOVE "  " TO WS1-PAGE-NBR
              MOVE WS1-PAGE-EDIT TO WS1-PAGE-NBR
              WRITE REP-RCD FROM WS1-HDR-AREA AFTER ADVANCING PAGE
              MOVE ZERO TO WS1-LCNT
    * Output Colour Sub Heading
              MOVE SPACES TO WS1-COLOR-CHECK
              MOVE TAG2-COLOUR TO WS1-COLOR-CHECK
              WRITE REP-RCD FROM WS1-SUB-HDR AFTER ADVANCING 3 LINES
              WRITE REP-RCD FROM WS1-SUB-HDR2 AFTER ADVANCING 1 LINE
              ADD 4 TO WS1-LCNT
              MOVE SPACES TO REP-RCD.

         IF WS1-COLOR-CHECK = TAG2-COLOUR
         THEN NEXT SENTENCE
         ELSE MOVE SPACES TO WS1-COLOR-CHECK
              MOVE TAG2-COLOUR TO WS1-COLOR-CHECK
              WRITE REP-RCD FROM WS1-SUB-HDR AFTER ADVANCING 3 LINES
              WRITE REP-RCD FROM WS1-SUB-HDR2 AFTER ADVANCING 1 LINE
              ADD 4 TO WS1-LCNT
              MOVE SPACES TO REP-RCD.

         MOVE TAG2-ACC-NBR TO REP-ACC-NBR.
         MOVE TAG2-TAG TO REP-TAG.
         MOVE TAG2-PRN TO REP-PRN.
         MOVE TAG2-QTY TO REP-QTY.
         WRITE REP-RCD AFTER ADVANCING 1 LINE.

    * Add up Tag Quantity for each Colour
         IF TAG2-COLOUR = 'BLU'
         THEN ADD TAG2-QTY TO WS1-BLU-ADD
         ELSE IF TAG2-COLOUR = 'RED'
              THEN ADD TAG2-QTY TO WS1-RED-ADD
              ELSE ADD TAG2-QTY TO WS1-BLA-ADD.

    * Add up Tag Cost for each Colour
         IF TAG2-COLOUR = 'BLU' AND TAG2-QTY = 24
         THEN ADD 2.25 TO WS1-BLU-TOT
         ELSE IF TAG2-COLOUR = 'BLU' AND TAG2-QTY = 36
              THEN ADD 3.00 TO WS1-BLU-TOT.

         IF TAG2-COLOUR = 'RED' AND TAG2-QTY = 24
         THEN ADD 2.25 TO WS1-RED-TOT
         ELSE IF TAG2-COLOUR = 'RED' AND TAG2-QTY = 36
              THEN ADD 3.00 TO WS1-RED-TOT.

         IF TAG2-COLOUR = 'BLA' AND TAG2-QTY = 24
         THEN ADD 2.25 TO WS1-BLA-TOT
         ELSE IF TAG2-COLOUR = 'BLA' AND TAG2-QTY = 36
              THEN ADD 3.00 TO WS1-BLA-TOT.

         ADD 1 TO WS1-LCNT.
         GO TO A01-OP-LINE.
     A90-END.
    * Print Control Report
         MOVE WS1-BLU-ADD TO WS1-BLU-TOTAL.
         MOVE WS1-RED-ADD TO WS1-RED-TOTAL.
         MOVE WS1-BLA-ADD TO WS1-BLA-TOTAL.
         MOVE WS1-BLU-TOT TO WS1-BLU-COST.
         MOVE WS1-RED-TOT TO WS1-RED-COST.
         MOVE WS1-BLA-TOT TO WS1-BLA-COST.
         WRITE REP-RCD FROM WS1-CONTROL-HDR AFTER ADVANCING 4 LINES.
         WRITE REP-RCD FROM WS1-RESULT1 AFTER ADVANCING 1 LINE.
         WRITE REP-RCD FROM WS1-RESULT2 AFTER ADVANCING 1 LINE.
         WRITE REP-RCD FROM WS1-RESULT3 AFTER ADVANCING 1 LINE.
         CLOSE TAG2-FILE REP-FILE.
         STOP RUN.
{% endhighlight %}

## Uuencode data file (TAG2.DAT)
{% highlight text %}
begin-base64 644 TAG2.DAT
MDAwMWEwMDAwMDAxYVJFRFNDMjRKaiAgICAgICAgICAgICAgICAgIDk0MTEy
MjAwMDJhMDAwMDAwMmFSRURTQzM2RC5Ccm93biAgICAgICAgICAgICA5NDEx
MjIwMDAzYTAwMDAwMDNhUkVEU1QyNFQuSm9uZXMgICAgICAgICAgICAgOTQx
MTIyMDAwNGEwMDAwMDA0YVJFRFNUMzZSLlRhbGJvdCAgICAgICAgICAgIDk0
MTEyMjAwMDVhMDAwMDAwNWFCTFVTQzI0Ui5KICAgICAgICAgICAgICAgICA5
NDExMjIwMDA2YTAwMDAwMDZhQkxVU0MzNkguTCAgICAgICAgICAgICAgICAg
OTQxMTIyMDAwN2EwMDAwMDA3YUJMVVNUMjRSLlAgICAgICAgICAgICAgICAg
IDk0MTEyMjAwMDhhMDAwMDAwOGFCTFVTVDM2Si5LICAgICAgICAgICAgICAg
ICA5NDExMjIwMDA5YTAwMDAwMDlhQkxBU0MyNFIuUCAgICAgICAgICAgICAg
ICAgOTQxMTIyMDAxMGEwMDAwMDEwYUJMQVNDMzZQLlAgICAgICAgICAgICAg
ICAgIDk0MTEyMjAwMTFhMDAwMDAxMWFCTEFTVDI0US5RICAgICAgICAgICAg
ICAgICA5NDExMjIwMDEyYTAwMDAwMTJhQkxBU1QzNk8uTyAgICAgICAgICAg
ICAgICAgOTQxMTIyCg==
====
{% endhighlight %}

## Compiling and running the program
* To compile this code I am using <a href="http://opencobol.org">OpenCOBOL</a> under Linux.  I compile it to en executable using: `cobc -x ASSIGN1.CBL`
* To create the TAG2.DAT file that is needed copy the uuencoded data above to a file, say tag2.uue.  Then run: `uudecode tag2.uue`
* To execute the program, make sure that TAG2.DAT is in the same directory as the executable ASSIGN1.  Then run `./ASSIGN1`

After running the program you should find a file called PRN has been created which contains the report.

## Example report (PRN)
<pre><samp>26/08/08          NAME TAG REPORT - 2               PAGE  1  


               COLOUR - RED                              
Acct.Nbr.       Name on Tag                  Type    Qty.    
a0000001a       Jj                           SC      24      
a0000002a       D.Brown                      SC      36      
a0000003a       T.Jones                      ST      24      
a0000004a       R.Talbot                     ST      36      


               COLOUR - BLUE                             
Acct.Nbr.       Name on Tag                  Type    Qty.    
a0000005a       R.J                          SC      24      
a0000006a       H.L                          SC      36      
a0000007a       R.P                          ST      24      
a0000008a       J.K                          ST      36      


               COLOUR - BLACK                            
Acct.Nbr.       Name on Tag                  Type    Qty.    
a0000009a       R.P                          SC      24      
a0000010a       P.P                          SC      36      
a0000011a       Q.Q                          ST      24      
a0000012a       O.O                          ST      36      



               CONTROLS                                  
 RED.........QUANTITY -  120       COST   $10.50         
 BLUE........QUANTITY -  120       COST   $10.50         
 BLACK.......QUANTITY -  120       COST   $10.50         
</samp></pre>
