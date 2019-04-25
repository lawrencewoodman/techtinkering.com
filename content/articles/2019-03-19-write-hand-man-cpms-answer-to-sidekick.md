CP/M is a single tasking operating system and having grown-up with single tasking systems this has never really been a problem for me.  There is style of program that would make my life easier, however.  When I was in college, using MS-DOS, we used a program called [Borland Sidekick](https://en.wikipedia.org/wiki/Borland_Sidekick).  This is a TSR that stayed in memory and when you pressed a hot key combination the program would display on the screen.  Sidekick was great because it would allow you to run a program from the DOS prompt and then if in the middle of this program you wanted to edit a document or check the ASCII table, you could press the correct keys and it would suspend your executing program and start Sidekick.

<a href="http://www.classiccmp.org/cpmarchives/cpm/Library/Magazines/TCJ/tcj_21%201985-1112.pdf" title="The Computer Journal Issue Number 21 - 1985"><img src="/img/articles/advert_write_hand_man.png" class="img-right"></a>

I was thinking of writing something like this as an RSX for CP/M Plus when I came across Write-Hand-Man.  It was published by Poor Person Software and version 2.1 seems to have been released around the mid 1980s.  As you would expect on CP/M-80 it isn't as functional as Sidekick but is useful nonetheless.  It comes with a notepad, phonebook, calender, directory lister, text-file viewer, calculator, ASCII chart, key macro editor and some sort of application swapper.

Setting up the program is simple.  WHM comes with a configuration program called, `WHMCONF`, which when run asks you three questions:

  * The terminal cursor home string, which for my VT100 is `<ESC>[H` so I use `1B5B48`
  * The hot-key that is pressed along with CONTROL. I use `@`
  * The amount of memory to reserve for WHM's loaded applications.  I use `2` as I'm only using the standard applications.

<img src="/img/articles/whm_menu_basic.png" class="img-left" style="clear: left;">


When WHM is activated through its hot key a little menu appears in the top left corner of the screen from which you can access the various functions.  These are loaded from disk as needed and you can even write your own programs for it.  The programs restrict themselves to a small window in the corner of the screen, but that keeps the memory usage down and is sufficient for many tasks.


WHM is still very new to me and I have recently been sent a manual for it, but unfortunately it doesn't cover the `SWAP` command that appears to allow some sort of task switching by saving the TPA to disk and allowing you to start another task.  I would love to get this working so am on the look out for more information about this.  I have also only been able to find a version for CP/M 2.2, whereas I normally use CP/M+, which the advert indicates there is a version for, so I'm also looking for a CP/M+ version.  If anyone can help with this it would be great to hear from you.  For now here is a video showing Write-Hand-Man in operation.

<div class="youtube-wrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/_a5b5AtnqXw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
