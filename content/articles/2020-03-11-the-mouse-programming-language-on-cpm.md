Mouse is an interpreted stack orientated language designed by [Peter Grogono](https://users.encs.concordia.ca/~grogono/) around 1975.  It was designed to be a small but powerful language for microcomputers, similar to Forth, but much simpler.  One obvious difference to Forth is that Mouse interprets a stream of characters most of which are only a single character and it relies more on variables rather than rearranging the stack as much.  The version for CP/M on the [Walnut Creek CD](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/) is quite small at only 2k.

Peter Grogono says in [Byte Magazine Volume 04 Number 07 - July 1979](https://archive.org/details/byte-magazine-1979-07/page/n197/mode/2up):

<blockquote cite="https://archive.org/details/byte-magazine-1979-07/page/n197/mode/2up">The justification for Mouse is that it incorporates many features of high level languages, yet it can be implemented without the resources needed by most high level languages.  More specifically, Mouse programs demonstrate the use and implementation of arrays, functions, procedures, nested control structures, local variables, recursion and several methods of passing parameters from one procedure to another.</blockquote>


## Hello, World! Example

As a first example to show what Mouse code looks like, here is a program to output "Hello, Word!" ten times to the screen.

``` text
~ Output 'Hello, World' ten times

10 c: ( c. ^ "Hello, World!" c. 1 - c: )
$
```

The first line beginning with `~` is a comment indicated by the `~` character.

Next we have `10 c:`  This pushes `10` onto the stack, then `c:` pops it off the stack and stores it in the `c` variable.  `c` is being used as a counter.

We now have a loop begun using the `(` character and ended using with `)`.  This loop will process its contents indefinitely until it is broken out of using the `^` character.

Next we have `c. ^`, the `c.` pushes the contents of variable `c` onto the stack and then `^` pops it off the stack and if it is less than 1 it breaks out of the loop.

`"Hello, World!"` outputs 'Hello, World', using `"` to output the string.  The `!` inside the string is converted to a newline character.

`c. 1 - c:` decrements `c` by first pushing its value to the stack using `c.` then subtracting `1` from the top of stack using `1 -`, then it stores the value on the stack back to the `c` variable using `c:`.

Finally the program ends using `$`.


## Instructions

Most instructions are a single character and all numbers are integers.


<div class="overflow-auto"><table class="neatTable neatBorder">
  <tr><th class="centre" >Symbol</th>
      <th class="centre" style="min-width: 16em">Action</th>
      <th class="centre" style="min-width: 30em">Notes</th>
  </tr>
  <tr><td class="centre">&lt;blank&gt;</td><td>No action</td><td></td></tr>
  <tr><td class="centre">$</td><td>End program / Define macro</td><td></td></tr>
  <tr><td class="centre">&lt;number&gt;</td>
      <td>Push &lt;number&gt; onto stack</td><td></td></tr>
  <tr><td class="centre">+</td><td>Add</td><td></td></tr>
  <tr><td class="centre">-</td><td>Subtract</td><td></td></tr>
  <tr><td class="centre">&ast;</td><td>Multiply</td><td></td></tr>
  <tr><td class="centre">/</td><td>Divide</td><td></td></tr>
  <tr><td class="centre">\</td><td>Remainder (modulo)</td><td></td><tr>
  <tr><td class="centre">?</td><td>Input number</td><td>Read a number from the keyboard and push its value onto stack</td></tr>
  <tr><td class="centre">?'</td><td>Input character</td><td>Read a character from the keyboard and push the value of its ASCII code onto stack</td></tr>
  <tr><td class="centre">!</td><td>Output number</td><td>Pop an operand from stack and display its value</td></tr>
  <tr><td class="centre">!'</td><td>Output character</td><td>Pop an operand from stack and display the corresponding ASCII character</td></tr>
  <tr><td class="centre">'&lt;char&gt;</td><td>Character literal</td><td>Push the ASCII code for the character &lt;char&gt; onto stack</td></tr>
  <tr><td class="centre">"</td><td>Output string</td><td>Display each character between the double quote and the next double quote.  Translate exclamation marks to newlines.</td></tr>
  <tr><td class="centre">&lt;letter&gt;</td><td>Variable address</td>
      <td>Convert the letter to an integer in the range
          0..25 (A = a = 0, B = b = 1, ..., Z = z = 25).  Add this
          value, which is an address in Data, to OffSet and push the
          result onto Stack.  NOTE:  LOCAL variables are supported.
          Lower case (a..z) variables are LOCAL.
          Upper case (A..Z) variables are GLOBAL.
      </td></tr>
  <tr><td class="centre">:</td><td>Store</td>
      <td>Pop two operands from stack and store the value
       of the second at the address in Data specified by the value
       of the first.
      </td></tr>
  <tr><td class="centre">.</td><td>Fetch</td>
      <td>Pop an operand from stack and push the
       value in Data of which it is the address.
      </td></tr>
  <tr><td class="centre">&lt;</td><td>Less than</td>
      <td>Pop two operands from stack.  If the first is
       less than the second, push 1, else push 0 onto stack.
      </td></tr>
  <tr><td class="centre">=</td><td>Equal</td>
      <td>Pop two operands from stack.  If they are
       equal, push 1, else push 0 onto stack.
      </td></tr>
  <tr><td class="centre">&gt;</td><td>Greater than</td>
      <td>Pop two operands from stack.  If the first is
       greater than the second, push 1, else push 0 onto stack.
      </td></tr>

  <tr><td class="centre">[</td><td>Start of conditional block</td>
      <td>Pop a value from stack.  If it is zero or negative,
          skip over characters until a matching ] is encountered.
      </td></tr>
  <tr><td class="centre">]</td><td>End of conditional block</td><td></td></tr>
  <tr><td class="centre">(</td><td>Start of loop</td>
      <td>Loop is infinite unless ^ is used to exit it</td></tr>
  <tr><td class="centre">)</td><td>End of loop</td><td></td><tr>
  <tr><td class="centre">^</td><td>Exit loop</td>
      <td>Pop an operand from stack.  If it is zero or
       negative, exit loop
     </td></tr>
  <tr><td class="centre">#&lt;letter&gt;</td><td>Macro call</td><td></td></tr>
  <tr><td class="centre">@</td><td>Exit from macro</td><td></td></tr>
  <tr><td class="centre">%</td><td>Macro parameter</td>
      <td>Pop a value from stack and use it to count
       parameters in the calling environment (parameter n follows
       the nth comma)</td></tr>
  <tr><td class="centre">,</td><td>End of parameter</td><td></td></tr>
  <tr><td class="centre">;</td><td>End of macro parameters</td><td></td></tr>
  <tr><td class="centre">{</td><td>Start trace</td><td></td></tr>
  <tr><td class="centre">}</td><td>End trace</td><td></td></tr>
  <tr><td class="centre">&amp;&lt;filename&gt;&amp;</td><td>Load and run &lt;filename&gt;</td>
      <td>With this feature several Mouse programs may be linked together</td></tr>
  <tr><td class="centre">~</td><td>Comment</td><td></td></tr>
</table></div>



## Macros

Mouse allows you to create macros/subroutines using the `$` character to define them and the `#` character to call them.  Within the macros the `%` character is used to reference the parameters and `@` says to end the macro.  The following code creates a macro to output which of two numbers is bigger.

``` text
~ Accept two numbers as input and say which is biggest

~ Get numbers
"Enter first number: " ? a:
"!Enter second number: " ? b:

#b,a.,b.;
$

~ Macro to output which number is biggest
$b 1% 2% = [ "!!Numbers are equal" @ ]
   1% 2% > [ 1% g: ] 2% 1% > [ 2% g: ]
   "!!Biggest number: " g. ! @
```

This code starts by asking for two numbers and uses the `?` character to accept input of a number.  The numbers are stored in variables `a` and `b`.

Once the numbers have been input the line `#b,a.,b.;` calls the macro defined lower down.  This uses `a.` and `b.` as arguments to give the macro the values within those two variables.  Parameters are separated with `,` and `;` indicates the end of the parameter list.

The `$` indicates the end of the main program.

The macro is defined using `$b` where `$` says define a macro and `b` is the name of the macro.  Within this it uses `1%` and `2%` to push the arguments onto the stack.

There is now a test for equality using `=` and we can see the use of conditional blocks begun with `[` and ended with `]`.  These are entered after popping the stack and if it is greater than or equal 1 processing is continued inside the block, otherwise the block is skipped until a `]` is reached.

In the first conditional block we can see that the subroutine ends if the numbers are equal.  This is done using the `@` character.

There then follows another two tests with conditional blocks which store the biggest number in `g`.

Finally the code finishes by outputting the biggest number and returning with `@`.


### Recursive Macros

You can even create recursive macros as the following program demonstrates by using recursion to output 'Hello, World!" ten times.


``` text
~ Output 'Hello, World' ten times using recursive macro

#p,10;
$
$p 1% [ "Hello, World!" #p,1% 1 - ; ] @
```

The line `#p,10;`  Calls the `p` macro with the argument `10`.

The next `$` ends the program.

The macro definition is started with `$p` and continues until `@` is reached.

Next we have `1%` which pushes the argument supplied to the macro to the top of the stack.  Here, it is being used to say how many more 'Hello, World!' messages should be output.

Now we have a conditional block indicated by the `[` and `]` characters, which in this case will process the block for each call to the macro unless it the argument to `p` reaches 0.

Inside the conditional block we have `"Hello, World!"` to output our message.

Next we call the macro again with `#p,1% 1 - ;`.  This time the argument is `1% 1 -` which pushes the supplied argument to the stack and subtracts `1` from it.


## Variables

The letter variables actually represent memory locations within an area for data storage.  So when for example the letter `A` is used it pushes 0 onto the stack and then `:` or `.` can be used to store/fetch a value to/from it.  Within macros we can use lower case letters to access local variables and uppercase values to access global variables.  The following program illustrates this.

``` text
~ Demonstrate var letter/memory locations

"Value of A: " A !
"!Value of B: " B !

#i,3;

~ Store 17 in data location 2
17 2 :

~ Show location/value for C
"!!Value of C: " C !
"!Value in C var: " C. !
$

$i
   "!!Inside $i 1%: " 1% !
   "!Inside $i value of A: " A !
   "!Inside $i value of a: " a !
   "!Inside $i value of B: " B !
   "!Inside $i value of b: " b !
   1% [ #i,1% 1 - ; ] @
```

The `!` character outputs the number on the top of stack, however within the strings output using `"`, each `!` is converted to a newline.

Output from above program:

``` text
MOUSE.MAC, 6/15/86
Value of A: 0
Value of B: 1

Inside $i 1%: 3
Inside $i value of A: 0
Inside $i value of a: 26
Inside $i value of B: 1
Inside $i value of b: 27

Inside $i 1%: 2
Inside $i value of A: 0
Inside $i value of a: 52
Inside $i value of B: 1
Inside $i value of b: 53

Inside $i 1%: 1
Inside $i value of A: 0
Inside $i value of a: 78
Inside $i value of B: 1
Inside $i value of b: 79

Inside $i 1%: 0
Inside $i value of A: 0
Inside $i value of a: 104
Inside $i value of B: 1
Inside $i value of b: 105

Value of C: 2
Value in C var: 17
```

<br />

The following program demonstrates that local variables, indicated with a lowercase letter, within macros are separate from global variables, indicated with an uppercase letter.  If a lowercase letter is used outside of a macro then it is taken to be the same as an uppercase letter and hence a global variable.

``` text
~ Test local variables

12 A:
17 a:
#c;

"!Outside $c  a = " a. ! " A = " A. !
$

$c 100 a: A. a. + a: "!Inside  $c  a = " a. ! " A = " A. ! @
```


Output from above program:

``` text
MOUSE.MAC, 6/15/86

Inside  $c  a = 117 A = 17
Outside $c  a = 17 A = 17
```

## Obtaining Mouse for CP/M

[Mouse](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/cpm/misc/mouse.lbr "MOUSE.LBR") can be downloaded from the [Walnut Creek CD](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/).  This version was updated by Lee R. Bradley and is based on the Z80 version published in "Mouse,  a  language  for Microcomputers", 1983, Petrocelli Books.

The .LBR file contains a few useful Mouse program, ending '.MSE', such as:

<dl>
  <dt>FILES.MSE</dt>
  <dd>Lists the files in the package</dd>

  <dt>HELP.MSE</dt>
  <dd>Lists the instructions</dd>
</dl>


## Video Demonstrating Mouse on CP/M

Mouse is an interesting and fun little programming language that can be seen being used in the following video.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/EaunbXlDUWI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
