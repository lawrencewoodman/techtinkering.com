[XCCP](http://cpmarchives.classiccmp.org/ftp.php?b=cpm%2FSoftware%2FWalnutCD%2Fcpm%2Fxccp "XCCP (v1.0) files from Walnut Creek CD: /cpm/xccp/") describes itself as an Extended Console Command Processor for CP/M. It supports the 8080 and v1.0 was released by Anton R. Fleig in 1984.  Like [EPEX](/articles/epex-an-environment-extension-for-cpm/ "TechTinkering Article: EPEX: An Environment Extension for CP/M"), XCCP doesn't require installing so we can begin using it by just running XCCP.COM at the cost of reducing TPA by about 3Kb.

XCCP requires a CP/M 2.2 environment, however it is missing a number of the built-in commands: REN, ERA, DIR, TYPE, USER and SAVE.    The USER command isn't needed because it's superseded by the improved user area handling provided by the shell.  REN.COM and ERA.COM are provided by XCCP, however unfortunately they don't support using DU: format to refer to files.  There are plenty of [DIR](/articles/dir-alternatives-on-cpm/ "TechTinkering Article: DIR Alternatives on CP/M") and [TYPE](/articles/text-viewers-on-cpm/ "TechTinkering Article: Text Viewers on CP/M") alternatives available to replace these missing commands.  If we want to use SAVE or SUBMIT then we can exit and return to the standard CCP using CTRL-Y.  The extra facilities of XCCP include:


## Command History

XCCP stores previous commands in a circular buffer which we can scroll through using CTRL-E to go back and CTRL-X to go forward.  This can store about 240 characters of command history.


## Command Line Editing

With the addition of command line editing, entering and editing recalled commands becomes much quicker and more comfortable.  The command line editing is done with WORDSTAR style commands:  CTRL-S to move the cursor left, CTRL-D to move the cursor right and CTRL-V to toggle insert/overstrike mode.  CTRL-H/Backspace/Delete erases characters to the right of the cursor unless the cursor is at the end of the text in which case it erases characters to the left.



## Command and Wildcard Completion

<img src="/img/articles/cpm_xccp.png" class="img-right" style="width: 500px; clear: right;" title="XCCP, showing search path, wildcard completion and improved user handling">

XCCP provides autocompletion using the ESC (ASCII 27) key.  If a drive isn't specified then this will look in the current drive and A0:.  If a drive is specified then it will look there.  This feature has two components.  First of all if we start typing a command and press ESC then it will either complete the command name or list possible names that begin with the characters that we have already typed.  The other, and possibly most interesting, part is that if we have anything after a command and press ESC then it will treat it as a wildcard and show us files that match it or if there is only one then it will replace the wildcard with the filename.  This is great if we've started typing a command and can't remember the exact name of the file we want to use.


## Improved User Area Handling

Like EPEX, the handling of user areas has been made much easier and the prompt displays the current drive and user area.  XCCP supports 'DU:' and 'U: format, where _D_ is the drive and _U_ is the user area.  This means that we can run a command from a different drive and user area by prefixing it with the appropriate DU:/U: combination.  For example, to refer to drive 'D', user area '3', we would use 'D3:'.  We can also change user area by simply typing the desired DU:/U: combination at the prompt and pressing return.  Unfortunately the supplied programs, ERA and REN, don't support this format.


## Automatic Searching of A0:

If we try to run a command and it isn't found in the current drive then A0: is automatically searched and if the command is found there then that command is executed.


## Multiple Commands per Line

Multiple commands can be combined on a single command line by using a ';' to separate them providing there is no white space either side of the ';' character.  The command line supports up to 127 characters on a single line and can also be used when we first start XCCP by appending the command with further commands that we want to run.  As an example from within XCCP, to change to drive I:, run `SD *.COM`, change to drive D: and finally run `I:SD *.COM`:
```
A0-> XCCP I:;SD *.COM;D:;I:SD *.COM
```
And from the normal CCP, running XCCP and telling it to process those commands:
```
A> XCCP I:;SD *.COM;D:;I:SD *.COM
```

## No Involuntary Warm Restarts

Warm starts are only performed if a user requests one by pressing CTRL-C.  This makes returning to the shell from an application much quicker and can even done in the middle of typing a command at the prompt without disrupting the command being typed.

## Conclusion

Like, EPEX, this is a great extension to a CP/M 2.2 system.  Its list of features is much smaller but then the program is much smaller.  For me, XCCP provides some of the most important features to make using CP/M easier but it would have been nice to be able to specify a search path as we can with EPEX.


## Video

The following video shows XCCP in action.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/NRwhmfYGX58" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
