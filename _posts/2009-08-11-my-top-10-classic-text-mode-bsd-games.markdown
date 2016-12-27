---
layout: article
title: "My Top 10 Classic Text Mode BSD Games"
summaryPic: small_bsd_games_trek_splash.jpg
tags:
  - BSD
  - Games
  - Retro
  - Text mode
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
Recently, I have been playing a collection of text mode games that were commonly found on Unix Systems during the 70s and 80s.  These games are surprisingly playable and, for me, they really show that there is more to gaming than flashy graphics.  As with any top 10 list, everyone will have their own opinions.  While you may disagree with my choices, my main aim is to encourage more people to check out these games and see that text mode still has a lot to offer.

The following games are all released under a BSD license with the exception of _phantasia_ which is explicitly not copyrighted.  For more information on each game have a look at their man pages.

### 10. go-fish
<img src="/images/posts/bsd_games_go-fish.jpg"/>

Each player has seven cards, the rest of the deck is left face down.  The object of the game is to collect "books" or all the members of the same rank, e.g. a book of 2s would be four twos, one of each set.  The players take it in turn to ask the other player for a card, if the other play has that card, i.e. a 3, then the player must give the requesting player all of the cards of that rank and the requesting player gets another go.  If the other player doesn't have any of that type then the requesting player has to pick from the deck and give the other player a go.  The game finishes when one of the players has run out of cards and the winner is the one with the most books.

It is really a children's game, but I sill like it.  I find it ideal to play when I know that I have only got a few minutes, such as between compiles, and want to relax for a bit.

Originally written by Muffy Barkocy.


### 9. gomoku
<img src="/images/posts/bsd_games_gomoku.jpg"/>

This two-person game is played against the computer on a 19x19 grid.  You have a choice of counters: black or white, with your opponent having the other colour.  The object is to take it in turn placing your counters, the winner is the first to get 5 in a row, horizontally, vertically or diagonally.

Originally written by Ralph Campbell.

### 8. trek
<img src="/images/posts/bsd_games_trek.jpg"/>

Inspired by Star Trek, this is a classic space exploration game.  When playing it, you have to remember that you are the captain of the space ship and hence have to rely on the information presented to you, when asked for, as opposed to having it all at one time.  It does take a little getting used to, but it is definitely worthwhile.

There is lots to do and all the favourite commands are there, to check the computer, control the shields, fire phasers and of course use the warp drive.  There are plenty of Klingons to fight with and from time to time you will get feedback from Sulu, Chekov, Uhura, Spock, etc.

As well as the standard man page for this, on most Linux distributions, there is an additional man page with a lot more information.  On Debian lenny it is at `/usr/share/doc/bsdgames/trek.me.gz` and can be read with `man` as follows:
{% highlight bash %}$ man /usr/share/doc/bsdgames/trek.me.gz{% endhighlight %}

Originally written by Eric P. Allman in 1976.

### 7. boggle
<img src="/images/posts/bsd_games_boggle.jpg"/>

A good version of the popular Parker Brothers game.  In this you are presented with a 4x4 grid of letters and you have 2&frac12; minutes to find as many words as you can with 3 or more characters made of connecting letters.  Another game that is great to play between compiles.

Originally written by Barry Brachman.

### 6. phantasia
<img src="/images/posts/bsd_games_phantasia.jpg"/>

On the face of it this game seems quite a simplistic turn-based role-playing game where you go around killing monsters.  However, once you get into it and find out how much there is to do, it is very enjoyable.  There are lots of different enemies, spells and treasures, all with their own characteristics.   phantasia is particularly good to play through multiple terminals.  It is worth spending some time, however, to study the man pages to get the most out of it.

Originally written by Edward Estes in 1986.

### 5. atc
<img src="/images/posts/bsd_games_atc.jpg"/>

A brilliant Air Traffic Control simulation, where you try to safely move aircraft in and out of the air-space that you control, in addition to helping aircraft to safely take off and land.  The control system works very well and for me it is a good example of how, with a bit of creative thinking, text mode can be used effectively.  It doesn't take long playing this to realize why air traffic controllers have a reputation for being stressed!

Originally written by Ed James in 1987.

### 4.adventure
<img src="/images/posts/bsd_games_adventure.jpg"/>

This is one that you can really get your teeth into.  You travel around an imaginary world, collecting treasure and solving puzzles, all the while making a map on paper so that you have an idea where you are.  The control system is fairly simple with just one or two word commands, and once you get the hang of this, it works really well.  It is also made easier by certain short-cuts such as just typing, 'building' to enter the building.

The game ADVENT, which adventure is based on, was written on a PDP-10 in FORTRAN by Will Crowther in 1976 and is considered to be the first adventure game.  The following year Don Woods expanded the game by adding fantasy elements and making it more puzzle-orientated.

Originally written by James Gillogly in 1977 as a port of the classic FORTRAN game ADVENT written by Will Crowther and Don Woods.

### 3. battlestar
<img src="/images/posts/bsd_games_battlestar.jpg"/>

I know it is sacrilege to rank this game above adventure, but I do prefer it.  It may be because I'm a much bigger fan of Science Fiction than I am of Fantasy.  I find the descriptions of the scenes are excellent at painting a picture while still being terse.  The control system is similar to adventure, but it also half-remembers what you were last doing, so for example if you said, 'take knife', then said 'drop', it would be the knife that would be dropped.

I'm not sure why this adventure isn't more popular.  Maybe, because by the time it was released, Zork had been around for two years.  It could also be because this game isn't really puzzle-orientated, but in a way I prefer that, as it means I can relax and just wander around enjoying the story.

Originally written by David Riggle in 1979.

### 2. hunt
<img src="/images/posts/bsd_games_hunt.jpg"/>

This is a multi-player games that can be played over a network, or via multiple terminals on one machine.  It consists of a top-down view of a maze where you run around trying to find your opponents to kill.  There are a number of weapons and you can also play in teams.  It is surprisingly fun, a sort of top-down text mode doom.

Originally written by Conrad Huang and Greg Couch in 1979/80.

### 1. rogue/hack
<img src="/images/posts/bsd_games_hack.jpg" title="Screenshot of Hack"/>

Rogue is one of the first graphical adventure games and has inspired many games, including Hack.  You are in a multi-levelled dungeon which you view from above.  Your aim is to explore the dungeon, fight the monsters, and retrieve the Amulet of Yendor, then ascend to the surface.  The game is quite simple to control and is completely absorbing.  It does need to be said, however, while the idea of the game and the control system are easy, it quickly becomes very difficult and takes a good deal of effort to make progress in the later levels.

Hack takes this concept and extends it by adding pets, shops and more monsters.

Rogue was originally written by Timothy Stoehr, Michael C. Toy, Ken Arnold and Glenn Wichman in 1980.  The code unfortunately does, however, have the following condition: _This code is not to be traded, sold, or used for personal gain or profit._ which leaves it as not properly free.

Hack was originally written by in 1982 by Jay Fenlason, with help from Kenny Woodland, Mike Thome and Jon Payne.  This was then virtually completely re-written by Andries Brouwer in 1984.


<h2>Where can I obtain these great games?</h2>
These games come as standard with most of the BSD Operating Systems as well as with a number of other Unixes.  In addition most Linux distributions have a package, often called <em>bsd-games</em> in their repositories.

If your distribution doesn't have a package for these games, they can be found at the <a href="ftp://metalab.unc.edu/pub/Linux/games/">upstream location</a> as <a href="ftp://metalab.unc.edu/pub/Linux/games/bsd-games-2.17.tar.gz">bsd-games-2.17.tar.gz</a> and because of licensing issues with rogue in the separate non-free archive <a href="ftp://metalab.unc.edu/pub/Linux/games/bsd-games-non-free-2.17.tar.gz">bsd-games-non-free-2.17.tar.gz</a>.  You can download these compile them and you are good to go.

If you are running another operating system, then you will find that these games have been ported directly to Windows,Dos,CP/M,etc and are available for download as individual games.

I hope you have fun and would love to hear of any early memories of these games, or what people think who have tried them for the first time recently.
