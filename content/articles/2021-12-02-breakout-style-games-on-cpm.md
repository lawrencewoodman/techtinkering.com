[Breakout](https://en.wikipedia.org/wiki/Breakout_(video_game)) style video games were pretty popular at one time both at Arcades and on home computers.   The games are based on a simple concept where you have to destroy a group of 'bricks' at the top of the screen by bouncing a ball off a paddle at the bottom of the screen.  This paddle can be moved left or right to meet the ball.  According to Wikipedia, _Breakout_ was released in 1976 by Atari, Inc.  I have found two versions for CP/M which are both quite playable.


## DBlick

<img src="/img/articles/cpm_dblick.png" class="img-right" style="width: 300px; clear: right;" title="DBlick running on a Commodore 128">

[DBlick](http://cpmarchives.classiccmp.org/cpm/Software/WalnutCD/lambda/soundpot/a/dblick-v.lbr "DBLICK-V.LBR from the Walnut Creek CD: /lambda/soundpot/a/") is the first conversion for CP/M that I came across.  It was written in Turbo Pascal and released in 1984 by D. Griffith and Andrew Zaslow.  The included source code says that it is configured for a Kaypro but as it uses ADM-3A terminal codes it will work with other machines that use or emulate this display such as the Commodore 128.

The game allows you to enter a skill level which governs the speed of the ball.  On the Commodore 128 I find that level '9' (Impossible!) is the best setting because the 128 runs CP/M fairly slow.  DBlick has a nice looking layout with a scoreboard but it redraws the entire screen each time you miss.  It also doesn't get the bounce quite right as the ball goes past the paddle before bouncing back.


## EVAS10N

<img src="/img/articles/cpm_evas10n.png" class="img-right" style="width: 300px; clear: right;" title="EVAS10N running on a Commodore 128">

[EVAS10N](https://github.com/marcosretrobits/EVAS10N.PAS/ "GitHub repo for EVAS10N.PAS") by [Macro's Retrobits](https://retrobits.itch.io/) is a 2020 rewrite of a BASIC 10 liner game written for the ZX Spectrum.  The README says that it was written on a ZX Spectrum Next and like DBlick it is also written in Turbo Pascal and includes the source code.  To run this on the Commodore 128 I needed to use the commented out character definitions for the ball, bat and bricks as well as alter the delay to 60.

I prefer the way this game updates the screen and it feels smoother.  However, it doesn't have a score board although this is understandable given that it is a rewrite of a BASIC 10 liner.  It would be easy to extend this game with a score if desired.


## Video

The following video shows the two games being played on CP/M and the source code for EVAS10N being altered and compiled in Turbo Pascal.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/2YwvgYZABmo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

