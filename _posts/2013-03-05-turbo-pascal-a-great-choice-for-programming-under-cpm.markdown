---
layout: article
title: "Turbo Pascal: A Great Choice For Programming Under CP/M"
tags:
  - Programming
  - Pascal
  - CP/M
  - Retro
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

CP/M was blessed with many programming languages, each with their own strengths and weaknesses.  I think that Turbo Pascal stands out from these and I'm not alone.  When Turbo Pascal was released in 1983 by Borland, as their first software development application, it was quickly adopted by schools, universities, hobbyists and professional software developers.  Turbo Pascal combined ease of use, power, speed and a great manual all for the really low price of $49.95.

## Why Use Turbo Pascal Under CP/M?
With TP you get an Integrated Development Environment (IDE), so that you can edit, compile and run all from the same application.  Since the IDE is only 34Kb there is plenty of space left on a disk for your source code and compiled programs.  This is particularly handy for single disk machines.  The editor is very functional and uses a subset of the Wordstar key combinations.

Pascal was designed to be easy to compile and because TP uses a single pass compiler, compilation speed is incredibly quick.  The downside of the compilation speed is that the code is quite a literal translation without much optimization.  However, for many applications this won't be much of an issue compared to the increased programmer productivity.

If you need parts of your program to run faster, you can always embed inline machine code into functions/procedures or access functions in external binaries.  The latter option allows you to create libraries in assembly language and use a jump table to access individual functions with the `external` keyword.

In 1986 Borland released Turbo Pascal 3.0 which added support for _overlays_.  The running code could now be swapped in and out from disk as needed.  With careful planning, you could escape the normal 64Kb limit and only be constrained by the capacity of the disk you are running the application from.

The standard library offers a good range of functions and TP keeps quite close to Standard Pascal as defined by Jensen & Wirth in their '[User Manual and Report](http://books.google.co.uk/books?id=xXSZbSLFTM8C&printsec=frontcover#v=onepage&q&f=false)'.  As with all Pascal implementations, there are problems porting programs between implementations.  However, if you aren't using any of the operating system specific calls, then you can easily port to the MS-DOS and CP/M-86 versions.  My only gripe is that TP doesn't support procedures and functions passed as parameters.

Finally, Borland included a highly readable and very complete [manual](http://bitsavers.trailing-edge.com/pdf/borland/turbo_pascal/Turbo_Pascal_Version_3.0_Reference_Manual_1986.pdf).  It covered not just the IDE, language and libraries, but also detailed information on the memory layout and calling conventions from assembly language.  This meant that you could quickly get up and running with few additional resources.

## How to install
First download [Turbo Pascal 3.01a](http://www.retroarchive.org/cpm/lang/TP_301A.ZIP) for CP/M-80 and unzip the archive.

Put at least `TINST.*` and `TURBO.*` files onto a disk.  The real advantage of not copying all the files is seen if you only have a single drive.  The extra room will allow you to edit, compile and run your programs all from the same disk.  For instructions on how to create a virtual disk for z80pack look at: [Setting up z80pack to Create an Emulated CP/M System](/2008/10/17/setting-up-z80pack-to-create-an-emulated-cpm-system/).

Boot up your CP/M system, put in the disk with TP on it and change to this drive if necessary.  In my examples I am using `B:`

Run the `TINST` program to set up the screen:

    B> tinst

Press `S` for _Screen Installation_ and select the appropriate terminal for your set up.  I'm using z80pack, so I select ANSI.  You probably don't want to alter this definition so say No to altering it.  Then enter the speed in Mhz of your machine.  If a suitable terminal isn't listed consult the TP manual for advice.

If you want to configure additional editor commands, you can do this via the _Command Installation_ option.  At the very least, if you have them, you'll probably want to configure the page-up, page-down keys as well as the cursor keys to represent character-left, character-right, line-up and line-down.  If not press `Q` to quit.


## Usage
To start the IDE run:

    B> turbo

You should now be looking at the Turbo Pascal splash screen, showing the version, copyright message and which terminal is configured.  At the bottom you are asked whether to 'Include error messages'.  For the moment press `Y`.

Now you will be presented with the main screen.  You have a number of commands on this screen, which are accessed by a single letter.

<img src="/images/posts/turbo_pascal_cpm_main.png" />

To work with a pascal source file, first press `W` and then enter a filename.  This is the file that the editor will open and it is also the file that the compiler will compile if you haven't selected a main file.

To edit the work file, press `E`.  The editor uses Wordstar key combinations which you can read more about in the manual.  For now the following keys will be useful to know:

<table class="neatTable" style="clear: left;">
  <tr><th>Key command</th><th>Action</th></tr>
  <tr><td>CTRL-s</td><td>Character Left</td></tr>
  <tr><td>CTRL-d</td><td>Character Right</td></tr>
  <tr><td>CTRL-e</td><td>Character Up</td></tr>
  <tr><td>CTRL-x</td><td>Character Down</td></tr>
  <tr><td>CTRL-k s</td><td>Save Document</td></tr>
  <tr><td>CTRL-k d</td><td>Quit</td></tr>
</table>
<br />
You can also use any keys that you configured above with the _Command Installation_ option in `tinst`.

Files are edited in memory so to save them to disk you press `S` from the main menu.

To compile and run the work file, or main file if selected, press `R`.  Depending on what is set in the compiler options, this will either compile to a `com` file or will compile to memory.


### Hello, world!

To try this with the traditional 'Hello, world!' program, set the work file to `hello.pas`, edit the file and enter the following, then quit the editor.
{% highlight pascal %}
program helloworld;
begin
  writeln('Hello, world!');
end.
{% endhighlight %}

Compile and run it by pressing `R` from the main menu.  You should see it compile and then say hello to the world.

### Creating a FizzBuzz Program

<object style="margin-top: 1em; margin-right:1em; margin-bottom:1em;" align="left" width="650" height="394">
  <param name="movie" value="http://www.youtube.com/v/acYu0sL9Ol0&amp;hl=en&amp;fs=1"></param>
  <param name="allowFullScreen" value="true"></param>
  <param name="allowscriptaccess" value="always"></param>
  <embed src="http://www.youtube.com/v/acYu0sL9Ol0&amp;hl=en&amp;fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="650" height="394"></embed>
</object>

The video above allows you to watch TP in action and see just how quick it is.  The source code for `fizzbuzz.pas` is as follows:
{% highlight pascal %}
program fizzbuzz(output);
var
  i: integer;
begin
  for i := 1 to 100 do
  begin
    if i mod 15 = 0 then
      write('FizzBuzz ')
    else if i mod 3 = 0 then
      write('Fizz ')
    else if i mod 5 = 0 then
      write('Buzz ')
    else
      write(i, ' ');
  end
end.
{% endhighlight %}


# What Now?
Get the [Turbo Pascal 3.0 Manual](http://bitsavers.trailing-edge.com/pdf/borland/turbo_pascal/Turbo_Pascal_Version_3.0_Reference_Manual_1986.pdf) for CP/M-80, CP/M-86 and PC-DOS/MS-DOS from [bitsavers.org](http://bitsavers.org).  It is a wonderfully well-laid out manual and you should have no problems using this to learn and get the most out of Turbo Pascal.  You may also want to take a look at a copy of the old Borland musuem page: [Antique Software: Turbo Pascal v3.02](http://edn.embarcadero.com/article/20792).

You are now ready to use Turbo Pascal to write and compile applications like it was 1986.
