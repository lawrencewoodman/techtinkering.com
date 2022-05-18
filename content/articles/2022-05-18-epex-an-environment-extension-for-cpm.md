[Epex](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/lambda/soundpot/a/epex11.lbr "EPEX11.LBR (v1.1) from Walnut Creek CD: /lambda/soundpot/a/") is an evironment extension for CP/M.  It stands for Environmental Processing EXecutive, and v1.1 was released by James H. Whorton in 1986.  It can make using CP/M much more comfortable at the cost of losing just under 5Kb of TPA.

EPEX requires CP/M 2.2, supports the 8080 and is really easy to use because it generally doesn't require installing; you just run EPEX.COM and you are in the environment.  The program comes with additional programs that make use of the extra facilities and these are supplied as .COM files such as ERA.COM, REN.COM, CP.COM, etc.  It provides many extra features, including:

## Search Path for Commands
Using the PATH command you can define a search path to find commands when entered at the command line.  First EPEX looks to see if a command is an internal command, if not then it looks in the current directory and if that fails then it goes through each directory in the _path_ to see if it can find a matching command.

## Easy Handling of User Areas
The handling of user areas has been made much easier and the prompt displays the current drive and user area.  EPEX supports 'DU:' format, where _D_ is the drive and _U_ is the user area, when combined they are termed a _directory_.  For example, to refer to drive 'D', user area '3', we would use 'D3:'.  This allows us to simply change to this directory by entering `D3:` at the prompt and pressing return.  We can also refer to commands and files on other drives or user areas by prefixing them with this 'DU:', directory format.  The supplied commands such as PATH, MKDIR, DIR, CP, etc fully support this and it will often work at the command line with commands that weren't written to support it.  Unfortunately you can't just use the user number followed by a colon as this will lead to a BDOS error.

## Named Directories

<img src="/img/articles/cpm_epex.png" class="img-right" style="width: 500px; clear: right;" title="EPEX, showing named directories and search path">

It is possible to give names to directories using the MKDIR command.  This takes a text file which maps directories e.g. 'A0:' to a name such as 'ROOT'.  When creating this file make sure that the names are in uppercase otherwise they'll fail to work properly.  The file could look like the following, which would create three named directories: ROOT, UTILS, ARCH.
````
A0:ROOT
I0:UTILS
C0:ARCH
````

The supplied commands such as CP and DIR fully support these named directories and they will often work with other commands at the command line.  The directory mappings can be changed at any time, which can be handy as you can have a script which refers to a named directory and change where that named directory points to at any time.  Sometimes I find that the last directory mapping doesn't register after MKDIR is run, however running PWD afterwards to display the mappings seems to correct this so I do that as a matter of course.

## Extended Batch Processing
The extended batch processing facilities includes the addition of local flow commands such as GOTO,IF,ELSE.  It also provides the ability to set and handle environment variables including command line arguments as well as the ability to handle errors returned by programs written to support EPEX.

## Aliases
EPEX allows you to wrap a command line or script in a .COM file either from a single line entered with the ALIAS command or from a text file using MKALIAS.  This script can be quite complicated because it can make use of the extended batch processing facilities.  As a simple example if we wanted to create an _alias_ called MD which runs the MKDIR command with the first command line argument and then runs PWD, we could supply the following to ALIAS or MKALIAS:

```
MKDIR $1;PWD
```

The `$1` refers to the first command line argument and the `;` is used by EPEX to combine multiple commands on a line.  One downside of creating an ALIAS is that the resulting command is quite big, in the case of MD.COM, it will be 2Kb.


## A Startup Script
When you run EPEX it tries to run ESTART.COM as a startup script.  This is created using the _alias_ facility described above.  In here you would typically define a search path and create named directories.


## 'Secure' Operating Mode
A _secure_ mode can be entered by running the SECURE command.  This will restrict which EPEX commands can be run and this makes it ideal for providing remote access to a system.  If we want to write software to support EPEX then it provides a system call which can be used to query whether we are in _secure_ mode.


## Environment Service Calls
EPEX provides additional service calls that can be called from assembly language so that we can write programs that make use of its extra facilities such as named directories, returning error codes, environmental variables, secure mode, etc


## Menu Building
EPEX comes with a tool, MKMENU, for creating menus.  You supply the tool with a text file which describes the menu and MKMENU will then create a .COM file which you can run to use the menu.  The text file can have upto four sections with each section delimited by a line containing a single `&`.  The four sections are: initial comments, the screen display, command definitions, trailing comments.

The example below is from the manual.  It shows a menu system that could be used when developing a program using an editor, assembler, etc.  In the screen display section we can see two environment variables: $s3 and $s4, these are set from user input using `inp str1` and `inp str2` in the command definitions section.  These environment variables persist between programs so that if you exit and enter the menu you will find that the variables haven't changed unless another program has changed them.  This is really handy and indeed you can create an alias which will first initialize variables and then run the menu.

```
This  example  menu  could  be  used  for assembler
development using LASM, MLOAD and VDO, all
public domain utilities.
&

...................................................
     8080 Assembler Development System Menu
      Work disk ->> $s4:  Work file ->> $s3
...................................................

       E - Edit work file.
       A - Assemble and Load work file.
       F - Change work file.
       C - Change work disk.
       R - Run work file.
       D - Directory of work disk
       L - Enter system command-line
       Q - Quit (exit assembler system)

&
E-vdo $s4:$s3.asm
A-lasm $s3.$s4$s4z;mload $s4:$s3;pause
F-echo enter new work filename -->> ;inp str1
C-echo enter new work disk -->> ;inp str2
R-echo running $s4:$s3...;$s4:$s3;pause
D-dir $s4:'Filespec: ';pause
L-'EPEX> ';pause
Q-echo exiting system...;set shell=
&
```


## Conclusion
EPEX is a great addition to CP/M 2.2 systems.  It provides lots of improvements at the cost of a small reduction in the TPA.  This reduction in memory often doesn't matter too much but for those times when it does, EPEX is easy to exit and then re-enter when we are ready.  However, there are two things which I wish it supported: i. Improved command line editing as seen in CP/M Plus ii. Command line history.  There are also a few bugs such as 'DIR' not reporting the correct size used/free on big drives as well as other bugs already mentioned in this article.

The version used in this article is v1.1, but there is a note included in the .LBR file that hints at another version coming out.  Does anyone know of a later version?  If so, I'd love it if you got in touch.


## Video

The following video shows EPEX in action.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/Mr0PuO9PwZE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
