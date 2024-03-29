Modula-2 is a great language in general and is a good choice for programming on CP/M.  There are three good compilers available for CP/M which all require a Z80 processor and we'll compare each in turn.


## Modula-2

Modula-2 was developed by Niklaus Wirth and is based on his earlier language, Pascal.  It introduces _modules_ to allow separate compilation of related code and data structures which are encapsulated to provide tight control of scope.  Modula-2 supports coroutines which make single processor concurrency relatively simple and provides easy access to low-level hardware.


## Turbo Modula-2

Turbo Modula-2 was released in 1986 by Echelon under license from Borland and then quickly withdrawn.  It was based on [Turbo Pascal](/2013/03/05/turbo-pascal-a-great-choice-for-programming-under-cpm "TechTinkering Article: Turbo Pascal is a Great Choice For Programming Under CP/M"), with a similar IDE and procedures such as `WriteLn` and `ReadLn` which replicate their use in Turbo Pascal rather than how they are used in other Modula-2 compilers.  We get the same ability to configure the key commands and terminal and generally the environment is very much like Turbo Pascal.

This is the smallest of the packages at about 200k and the IDE is a single executable which makes it easy to switch between compiling, linking, editing and various file handling operations.  The compiler can output either an intermediate code called M-code or native code.  The former compiles quicker and is said to take up less than a third of the space of native code but as it is interpreted it runs slower.  It is possible to combine modules compiled to M-code with those compiled into native code so that you can get the best of both worlds.  There is also a profiler available although it is restricted to M-code.

It provides two main ways to call machine language from Modula-2 code.  The first is fairly easy as it allows us to replace a procedure's body with the contents of a .COM file.   We do this using the `CODE` statement which will load the named .COM file at compile time and use its contents as the body of the procedure.  The code must be fully relocatable and will be called with a consistent environment so that parameters can be read and a value returned.  As an example the following, taken from the manual, would load a file called 'MOVE.COM' and use it to create the body of the procedure.

```
PROCEDURE MOVE(source,dest: ADDRESS; n: CARDINAL);
  CODE("MOVE")
END MOVE;
```

The second way is by linking Microsoft Relocatable Files which is a little more complicated as we need to create a definition file and then combine this with the relocatable code using the supplied 'REL' command to create a .MCD file.  However, this has the added bonus that we can not only call procedures created with Microsoft's assembler but we can also call procedures created by Microsoft Fortran, Pascal MT/+, etc.

Turbo Modula-2 comes with a good selection of modules to handle the normal things you would expect including modules to aid working with the terminal and to provide access to CP/M BDOS and BIOS calls.  This implementation provides the fewest number of compiling and linking options out of the three compared.

The compiler is available as an [archive](http://www.retroarchive.org/cpm/lang/TMOD210.ZIP "TMOD210.ZIP from the Retrocomputing Archive") at the [The Retrocomputing Archive](http://www.retroarchive.org/cpm/lang/lang.htm).  There is also a good manual but unfortunately the quality of the [scan](http://oldcomputers.dyndns.org/public/pub/manuals/turbomodula2_bw.pdf "Turbo Modula-2 Manual") is fairly poor.


## FTL Modula-2

FTL Modula-2 aims to closely implement the Modula-2 language and modules as described by Niklaus Wirth in his book 'Programming in Modula-2'.  In this it does a good job and is the version I have the greatest confidence in considering that it has gone through multiple versions over quite a long period of time.  The latest version I have found is v1.30, dated 26 July 1988 and is available at [The Retrocomputing Archive](http://www.retroarchive.org/cpm/lang/lang.htm) as [FTL-M2.ZIP](http://www.retroarchive.org/cpm/lang/ftl-m2.zip).

The package comes with an editor, compiler, linker, assembler, debugger and library manager.  It also has utilities to configure the terminal and search paths.  The search paths allow us to spread our Modula-2 files over several drives without having to constantly specify the location of source and output files.  This is particularly useful if running from floppy drives or RAM drives as this is much bigger than Turbo Modula-2 at about 600k and therefore we can split it over multiple drives.  The terminal configuration is used by the built-in editor as well as the ScreenIO module which provides functions to move the cursor, set attributes, etc.

The editor is integrated with the compiler which allows us to compile from the editor and then return to it.  It can edit up to three files in split screen mode and I find it to be a very quick and comfortable editor.  The editor generally uses Wordstar keys with the addition of macros inspired by Emacs.

There are two manuals:
* The [user manual](https://www.cpcwiki.eu/imgs/9/92/Hisoft_FTL_Modula-2_Z80_User_Guide_%28Hisoft%29_Manual.pdf) which provides a concise but complete description of configuring the environment and the commands and modules included.
*  The [language reference](https://www.cpcwiki.eu/imgs/b/be/Hisoft_FTL_Modula-2_Language_Reference_%28Hisoft%29_Manual.pdf) which teaches the language and highlights certain areas where this implementation may differ from other implementations.


A full range of modules are provided, including modules supporting screen handling, direct access to CP/M BDOS and BIOS data structures and calls.

The compiler and linker take a range of options, one of the most useful is /D for the linker (ML.COM).  This allows us to control the placement and initialization of data.  It is important because it can produce dramatically smaller files but if we are to distribute these files we need to specify the placement so that it doesn't write over systems that are configured differently.  To do this we run ML without the /D option and then run it again using the 'Top Address' reported in the first run as the address for the /D switch.



## Peter Hochstrasser's Modula-2

Peter Hochstrasser made his Modula-2 System for CP/M more freely available in 2002.  His release statement, the manual and 3 disk archives of v2.01 dated 4 June 1985, are available at the [developer's tools](http://www.cpm.z80.de/develop.htm) section of The Unofficial CP/M Web site.  This is about the same size as FTL Modula-2 at around 600k and like it we can spread the files over multiple disks and configure search paths with MP.COM.  Despite the large size, this implementation is the only one which doesn't come with an editor

As with the other compilers this Modula-2 comes with a good selection of modules including support for making CP/M BDOS and BIOS calls.  However, unlike the others it doesn't have support for terminals beyond what CP/M provides.  Therefore, if we want to have features such as moving the cursor then we have to write this ourselves.  The compiler and linker have a number of options but unfortunately don't have options to speed up execution by turning off range checking for example.

In order to call machine language routines, Hochstresser's Modula-2 allows us to link Microsoft Relocatable files using a similar, although slightly more complicated, process as described for Turbo Modula-2.



## Benchmarks

To compare the compilers we can use a simple [Prime Sieve Benchmark](#article-benchmark-code).  Any benchmark will be flawed as compilers will often have types of code that it can compile into an executable that runs faster or is smaller than another.  However, this seems like a reasonable test as it contains many common operations such as iteration, branching and array access.

The following table shows the average _build_ (compiling + linking) and _execution_ times for the various compilers and options.  These tests were performed under [z80pack](/articles/emulating-a-cpm-system-with-z80pack/) running at 4Mhz and therefore doesn't allow for the increased disk access time of a real system.

<table class="neatTable" style="width: 100%">
  <tr><th>Compiler</th><th title="Total time to compile and link" class="right">Build</th><th title="Execution Time" class="right">Execution</th><th title="Executable Size" class="right">Size</th></tr>
  <tr><td>Turbo Modula-2 (M-Code)</td><td class="right">5s</td><td class="right">2m 8s</td><td class="right">16Kb</td></tr>
  <tr><td>Turbo Modula-2 (Native code)</td><td class="right">9s</td><td class="right">9s</td><td class="right">16Kb</td></tr>
  <tr><td>FTL Modula-2</td><td class="right">10s</td><td class="right">15s</td><td class="right">12Kb</td></tr>
  <tr><td>FTL Modula-2 (Using /D:xxxx)</td><td class="right">9s</td><td class="right">15s</td><td class="right">4Kb</td></tr>
  <tr><td>Peter Hochstrasser's Modula-2</td><td class="right">20s</td><td class="right">19s</td><td class="right">2Kb</td></tr>
</table>

There is no clear winner but depending on our priorities in terms of build time, execution time or executable size we may favour one compiler over another.  This is also very specific to the code tested.  If we had used a bigger program and execution time wasn't an issue then perhaps the more compact M-code would have shone.

## Video

The following video shows the Modula-2 compilers in action.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/he-Yt_fCRYg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>


## Summary

Modula-2 is a language worth considering for your next project on CP/M and hopefully this quick comparison will help you to determine which one to use.  Whichever you choose the language is pretty similar between the three so it should be easy to port from one to another.

---

<h2 id="article-benchmark-code">Benchmark Code</h2>

For the comparison above a prime sieve benchmark was used which came from Turbo Modula-2.  The following version has been adapted for FTL Modula-2.

```
MODULE primes;

FROM Terminal IMPORT WriteString,WriteLn,Read;
FROM SmallIO IMPORT WriteCard;

CONST
  size = 8190;

VAR
  flags : ARRAY [ 0 .. size ] OF BOOLEAN;
  i, prime, k, count, iter : CARDINAL;
  ch : CHAR;

BEGIN
  WriteString("Type Return"); Read(ch);
  WriteString("10 iterations"); WriteLn;
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
  WriteCard(count, 1); WriteString(" primes"); WriteLn;
  WriteString("done"); WriteLn;
END primes.
```
