I have written previously about why [Turbo Pascal is a Great Choice For Programming Under CP/M](/2013/03/05/turbo-pascal-a-great-choice-for-programming-under-cpm) and now it is time to talk about what could have been.  You probably haven't heard of Turbo Modula-2 for CP/M as it was only on the market for a brief period of time.  However, it was a superb product and, in many ways, feels like a grown-up version of Turbo Pascal.  Why TM-2 made such a fleeting appearance is shrouded in mystery.  It was released in 1986 by Echelon under license from Borland and then quickly withdrawn.  There doesn't seem to be any publicly documented reason for the withdrawal and it is said that Borland even denied its existence for a time.  I want to show why it was a real shame this happened, and how much better a programmer's life could have been.

## Integrated Development Environment
Like Turbo Pascal, Turbo Modula-2 was an Integrated Development Environment including a compiler and Wordstar based editor.  On top of this TM-2 added a separate linker and library manager.  The most obvious initial difference is the size of an installation: TM-2 takes up 142Kb, compared to TP's tiny 34Kb.  However for this you get a lot more facilities, a bigger library and an altogether more sophisticated system.


## Language Enhancements
The language itself is similar to TP and it is pretty easy to convert TP code to TM-2.  With TM-2 you get many of the things that are liked about TP, including overlays, easy access to machine-code functions and a good standard library.  In addition the library has been extended and you gain more numeric data types, coroutines, exceptions, procedures as parameters, typeless parameters, etc.  To have these facilities on a CP/M machine in 1986 would have been incredible.

### Modules
The _Modula_ in Turbo Modula-2, of course indicates the use of modules to separate code.  These are similar to _Units_ in later versions of Turbo Pascal.  They allow you you to hide data and functions within a namespace and only expose what you want to.  Because of this isolation it allows the linker to only link-in functions that are used and hence reduces the executable size.  In addition, because the modules are separate they can be compiled separately.  Therefore when you make a change to your codebase, you only need to recompile the modules that have actually changed, which on a big project can greatly increase build speeds.

## Native vs M-Code
Each module can be compiled to either native Z80 code or to M-code to be run on the built-in virtual machine.  This allows you to compile code that doesn't need to run quickly to M-code, which executes more slowly, but compiles much quicker and the manual says it generally takes about 1/3 the size of native code.  Then, for code that must run quickly you can set the IDE to compile to native Z80 code which runs much faster, but takes up more disk space and compiles more slowly.  Because of the separate linker you can freely mix modules compiled with either native or M-code and hence get the best of both worlds.

## Size and Speed Compared
To compare the performance of TP and TM-2, I am using a program based on the Prime Sieve benchmark included with TM-2.

The code for the Prime Sieve in Turbo Pascal:
```` pascal
program primes(input, output);

const
   size = 8190;

var
   flags : array [0..size] of boolean;
   i, prime, k, count, iter : integer;
   ch: char;

begin
  writeln('Type Return'); readln(ch);
  writeln('10 iterations');
  for iter := 1 to 10 do
  begin
    count := 0;
    for i := 0 to size do
    begin
      flags[i] := true;
    end;

    for i := 0 to size do
    begin
      if flags[i] then
      begin
        prime := i + i + 3;
        k := i + prime;
        while k <= size do
        begin
          flags[k] := false;
          k := k + prime;
        end;
        count := count + 1;
      end;
    end;

  end;
  writeln( count, ' primes');
end.
````

The code for the Prime Sieve in Turbo Modula-2:
```` pascal
MODULE primes;

CONST
  size = 8190;

VAR
  flags : ARRAY [ 0 .. size ] OF BOOLEAN;
  i, prime, k, count, iter : CARDINAL;
  ch : CHAR;

BEGIN
  WRITELN("Type Return"); READLN(ch);
  WRITELN("10 iterations");
  FOR iter := 1 TO 10 DO
    count := 0;
    FOR i := 0 TO size DO flags[i] := TRUE END;
    FOR i := 0 TO size DO
      IF flags[i] THEN
        prime := i + i + 3;
        k := i + prime;
        WHILE k <= size DO
          flags[k] := FALSE;
          k := k + prime;
        END;
        count := count + 1;
      END;
    END;
  END;
  WRITELN( count, " primes" );
END primes.
````

The following table shows the average results from running each test 10 times and timing their execution and build (compiling + linking).  This was performed under [z80pack](/articles/emulating-a-cpm-system-with-z80pack/) running at 4Mhz and therefore doesn't allow for the increased disk access time of a real system.  For the TM-2 tests it also doesn't include the time to manually answer the questions required to build, instead it is just the processing time.

<table class="neatTable">
  <tr><th>Compiler</th><th title="Total time processing during compiling and linking">Build</th><th title="Execution Time">Execution</th><th>Executable Size</th></tr>
  <tr><td>Turbo Modula-2 (M-Code)</td><td>6 Seconds</td><td>2 Minutes 8 Seconds</td><td>16Kb (123 records)</td></tr>
  <tr><td>Turbo Modula-2 (Native code)</td><td>9 Seconds</td><td>8 Seconds</td><td>16Kb (125 records)</td></tr>
  <tr><td>Turbo Pascal (Native code)</td><td>&lt; 1 second</td><td>24 Seconds</td><td>9Kb (67 records)</td></tr>
</table>

Your can see from the table that there are trade-offs for each option and no-clear winner.  It therefore comes down to how the compiler will be used.  If you need very fast running code or have a large codebase then TM-2 will probably be a better choice.  However, if your program is smaller and doesn't need to run so quickly or you are happy to rely on assembler for extra speed, then you may find TP a better option.


## Should I Switch From Turbo Pascal to Turbo Modula-2?
There is a [manual](http://oldcomputers.dyndns.org/public/pub/manuals/turbomodula2_bw.pdf) available online, which while a poor scan, is certainly good enough to teach the language and TM-2 is similar enough to TP that it should be fairly easy to make the switch.  However, TM-2 is a bit of an unknown quantity when it comes to reliability and bugs, because not all that many people used it, compared to the huge number of Turbo Pascal users.  This also means that you are less likely to get help for TM-2 than TP.

However, if you feel brave, there are certainly big advantages to be gained from TM-2, especially with larger projects.  So why not download a [Turbo Modula-2 archive](http://www.retroarchive.org/cpm/lang/TMOD210.ZIP "TMOD210.ZIP") from the retroarchive [programming languages](http://www.retroarchive.org/cpm/lang/lang.htm) page and give it a go.  If you have used, or now choose to use TM-2, do leave a comment to share your experiences.
