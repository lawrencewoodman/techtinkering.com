[Pilot](https://en.wikipedia.org/wiki/PILOT) was created by John A. Starkweather in the early 1960s as a programming language for Computer Assisted Instruction.  It has often been compared to [Logo](https://en.wikipedia.org/wiki/Logo_(programming_language)) because of its use with children.  However, it is a much simpler language than Logo and really specializes in providing an easy way to create question and answer systems.

## Language Description

Pilot source code consists of lines of the following format:

&lbrack;label&rbrack;&lbrack;command&rbrack;&lbrack;conditional expression&rbrack;:&lbrack;operands&rbrack;

_Labels_ are prefixed with `*` and are used by `J:` to Jump to and by `U:` to call a User subroutine.

Common _Commands_ are listed in a table below.

The _conditional expression_ is generally `Y` or `N` to indicate whether to execute the command based on the last `M:` Match command.  Some implementations of Pilot also support more complicated expressions.

The _operands_ for a command are delimited by commas.


<div class="overflow-auto"><table class="neatTable neatBorder">
  <tr><th>Command</th><th>Action</th></tr>
  <tr><td>A:&lt;Variable&gt;</td><td>Ask for keyboard input and put result in <em>Variable</em></td></tr>
  <tr><td>C:&lt;Expression&gt;</td><td>Compute <em>Expression</em></td></tr>
  <tr><td>E:</td><td>End user subroutine / program</td></tr>
  <tr><td>J:&lt;Label&gt;</td><td>Jump to <em>Label</em></td></tr>
  <tr><td>M:&lt;List&gt;</td><td>Match last keyboard input against any value in <em>List</em> (Set Y/N logic flag)</td></tr>
  <tr><td>R:&lt;Comment&gt;</td><td>Remark / Comment</td></tr>
  <tr><td>T:&lt;String&gt;</td><td>Type <em>String</em> to display</td></tr>
  <tr><td>U:&lt;Label&gt;</td><td>Jump to a User subroutine at <em>Label</em></td></tr>
</table></div>


_Variables_ are prefixed with a `$` if a string and for those implementations that support numbers they are generally prefixed with a `#`.


## Example: Looping Hello, World!
This example prints 'Hello, World!' ten times with the number prefixing the string.

``` text
         C: I=1
*LOOP    T: #I Hello, World!
         C: I=I+1
         C: J=11-I
      J(J): *LOOP
         E:
```

The line to print the message, `*LOOP    T: #I Hello, World!`, uses `#I` to reference the variable `I`.  The loop is controlled by the line `J(J): *LOOP`, which uses a conditional expression, `(J)`, to indicate that the jump should be performed if 'J > 0'.


## Example: String Matching and Subroutines
This example demonstrates string matching and subroutines as it repeatedly asks a user to type `STRAWBERRIES`, `QUIT` or `EXIT`.  If the user types `STRAWBERRIES` it will tell the user how much it likes them with cream  and if the user types either `QUIT` or `EXIT` it will exit the program.

``` text
*LOOP     T: TYPE STRAWBERRIES OR ELSE (OR QUIT OR EXIT)
          A: $FRUIT
          M: QUIT,EXIT
         JY: *QUIT
          M: STRAWBERRIES
         UY: *ILIKE
          J: *LOOP
*ILIKE    T: I SURE LIKE $FRUIT AND CREAM
*QUIT     E:
```

The line `A: $FRUIT` accepts a string into the variable `FRUIT`, which is then tested to see if it matches either `QUIT` or `EXIT` using `M: QUIT,EXIT`.  The `M:` command sets the logic flag which is then tested with `JY: *QUIT` and if it is true (Yes) then the program jumps to the label `*QUIT`.  If not then the accept string is tested against `STRAWBERRIES` and if it matches then the subroutine `*ILIKE` is called with, `UY: *ILIKE`.  The `*ILIKE` subroutine refers to the accepted input string through the variable `$FRUIT` in, `T: I SURE LIKE $FRUIT AND CREAM`.  Finally `E:` is used to exit the subroutine and doubles as the program quit indicator at `*QUIT`.  Unfortunately, for some reason `E:` doesn't seem to exit '8080 PILOT' properly.

## 8080 PILOT

8080 PILOT was written by John A. Starkweather, the original author of Pilot, under contract to the Lister Hill National Center for Biomedical Communications, National Library of Medicine.  This was ported to CP/M by John I. Frederick in 1977 and v1.2 is available on the Walnut Creek CD in [CPMUG012.ARK](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/simtel/cpmug/cpmug012.ark "CPMUG012.ARK").  Although the version number of the executing program states v1.1.  Interestingly, although this version was released in 1977, John Starkweather says in the March 1982 edition of InfoWorld that [he is *going* to release a CP/M version](https://books.google.co.uk/books?id=fz4EAAAAMBAJ&pg=PA47&redir_esc=y#v=onepage&q&f=false).  There is a [Guide to 8080 Pilot, Version 1.1](https://archive.org/details/dr_dobbs_journal_vol_02_201803/page/n173/mode/2up) in the April 1977 issue of Dr. Dobbs Journal.

The examples above are written for _8080 PILOT_.


## Z-80 PILOT

Also in the file [CPMUG012.ARK](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/simtel/cpmug/cpmug012.ark "CPMUG012.ARK") is a much smaller version of Pilot written for the Z-80.  The source code is only 7k and the .COM file is only 1k, compared to 8080 PILOT whose source code is 67k and .COM file is 5k.  However, this smaller size comes at a cost.  This version doesn't support subroutines or numeric variables.  It also refers to variables in a `T:` command using a `\`, e.g. `\fruit` and `A:` doesn't accept a variable name, instead it uses the label of the line on which the `A:` is being executed to indicate the variable name.  Despite these differences for many uses it wouldn't matter much if you just want to present information and question a user.

## PILOT/80
[PILOT/80](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/languags/pilot80/pilot80.lbr "pilot80.lbr") was written in MBASIC by Kurt Albrecht and the version on the Walnut Creek CD is dated 1983.  It contains its own text-editor, although you can use any editor to create the Pilot source programs by saving them with a '.PIL' extension.  Its use of MBASIC does make it slower but that may not be much of a problem because it doesn't support maths through the `C:` command.  The documentation is good and I like the inclusion of the `I:` command to accept single key input as well as the `S:` command to handle screen functions such as `CLEAR` to clear the screen.


## Pilot/P

[Pilot/P](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/simtel/sigm/vols200/vol237/pilot-p.lbr "pilot-p.lbr") takes Pilot source code and transpiles it to Pascal/Z source code.  It was written by David Mundie and Raymond E. Penley and the Walnut Creek CD contains v2.5 from 1984.  This implementation departs quite a lot from other Pilot implementations by having a more complex subroutine definition using `%:` and allowing Pascal statements to be integrated into the Pilot source code.  It also has additional commands such as `X:` to process an expression which then sets the logic flag.  One last significant change is that variables are referred to by the `T:` command by surrounding them with the `@` symbol, e.g. `@$varName@`.

Pilot/P contains great documentation, has lots of examples and uses 'SUPERSUB' (renamed as 'DO.COM') to automate the process of transpiling to Pascal/Z source code, compiling and linking.


## Video Demonstrating Pilot on CP/M

Pilot can be seen being used in the following video.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/_6VpvHYHlrg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
