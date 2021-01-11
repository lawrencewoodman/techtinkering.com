After a transient program terminates on CP/M it's often possible to re-execute it  in memory without having to reload it from disk.  This is a great little trick if using slow disks as it's much quicker to just jump back into memory.  It's also useful because it could prevent you from losing work if you exited a program without saving.

## Creating the Re-execute Command
The re-execute command is the smallest possible command.  It is simply an empty .COM file.  We can easily create an empty file called 'RERUN.COM' using the resident 'SAVE' command:

```
SAVE 0 RERUN.COM
```

## Using the Re-execute Command

<img src="/img/articles/cpm_memory_layout_tpa_ccp.png" class="img-right" style="width: 500px; clear: right;" title="CP/M Memory Layout">

Under CP/M, programs that load from disk are referred to as _Transient Programs_ and these run in an area of memory called the _Transient Program Area (TPA)_ starting at location 0100h.  A transient program is normally run from the command line by the _Console Command Processor (CCP)_ located above the TPA.  When a transient program finishes it generally returns control to the CCP.  This is often done by initiating a warm start by jumping to location 0000h.

After we have exited a program we can re-execute it by running the 'RERUN' command we created earlier.  This would cause the CCP to load it into the TPA and jump to its start at 0100h.  However, because the 'RERUN' command is empty it doesn't write over the existing program in the TPA and instead starts executing it from the start.  This won't always work though as often programs won't reinitialize their variables when a program starts or they may write over the CCP in which case reloading it would corrupt this part of the program.  Therefore, it takes a certain amount of trial and error to find which programs this will work for.


## Example

Below we demonstrate this by entering a program into [TINY BASIC](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/simtel/cpmug/cpmug002.ark "CPMUG002.ARK - Contains Tiny Basic"), exiting from Basic (using `BYE`), running `RERUN` to re-execute Basic and then seeing that the Basic program is still intact in memory.  This would be very useful if we forget to save our entered Basic program as we could jump back into it and then save it.

```
D>TINYBAS

SHERRY BROTHERS TINY BASIC VER. 3.1

OK
>10 FOR I=1 TO 5
>20 PRINT "HELLO WORLD!"
>30 NEXT I
>BYE

D>RERUN

OK
>LIST
  10 FOR I=1 TO 5
  20 PRINT "HELLO WORLD!"
  30 NEXT I

OK
>RUN
HELLO WORLD!
HELLO WORLD!
HELLO WORLD!
HELLO WORLD!
HELLO WORLD!

OK
>
```


## CP/M Plus

This procedure won't work on CP/M Plus as during a cold or warm start it overwrites the start of the TPA with the CCP and therefore if we were to run our 'RERUN' command it would just jump to the CCP and continue executing.

## Video

The following video shows the Re-execute command being used.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/y3RzAmlTXsE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
