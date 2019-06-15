Hunt The Wumpus was created by Gregory Yob in 1973 after seeing some of the hide and seek style games distributed by the People's Computer Company.  Games such as  Hurkle, Snark and Mugwump were all based on a 10x10 grid using Cartesian coordinates, but Yob thought that he could create a more interesting game without using a grid system and released it through the [PCC](https://archive.computerhistory.org/resources/access/text/2017/09/102661095/102661095-05-v2-n2-acc.pdf "People's Computer Company Newletter - Vol 2. No. 2 - November 1973").

<img src="/img/articles/cpm_wumpus.png" class="img-right" style="width: 450px; clear: right;">

The premise of the game is that you are in a cave system of connecting 'rooms' and must hunt and kill a creature called the Wumpus.  At each turn you can move to one of three connecting rooms or shoot an arrow.  You must be careful though as there are two rooms containing bottomless pits that you can fall into and two rooms that contain 'Super Bats' that can carry you off to another room.  The Wumpus is asleep most of the time, but if you move into its room or it hears you shoot an arrow it will wake and move to another room.  If you enter a room where the Wumpus is, or it moves into a room that you are in, it will kill you.  To help you on your hunt you are warned if their is a pit, bat or Wumpus in an adjacent room with messages such as: 'I feel a draft', 'Bats nearby' or 'I smell a Wumpus'.

<a href="https://github.com/lawrencewoodman/techtinkering.com/blob/master/attribution.md" title="Attribution Details"><img src="/img/articles/496px-Dodecahedron_schlegel_diagram.png" class="img-left" style="width: 250px; clear: left;"></a>

In the original version of the game, the cave system was a regular dodecahedron with each vertex representing a room.  This was extended by Wumpus 2 which added five more caves, each with different properties.  The cave systems were consistent and used the same room number for each vertex, therefore you could create maps like the flattened dodecahedron in the image to the left.

<br style="clear:left;" />

## Strategy

Gregory Yob envisioned that people would use the maps and then carefully narrow down where the Wumpus must be before killing it, but he says that it turned out that people preferred to chase the Wumpus instead.  Your are free to choose the best strategy for yourself.

Interestingly work was done on 'Computer Assisted Instruction' at MIT to create a [Wumpus Advisor](https://archive.org/details/DTIC_ADA036678/page/n3) program which would offer advice to a player as to how to choose the best move in a game.  Thanks to [Martin on comp.os.cpm](https://groups.google.com/d/msg/comp.os.cpm/aTdGmgDKF-c/2YIrPicqCgAJ) for finding that report.

## Fixing the Version on the Walnut Creek CD

The version of Hunt the Wumpus on the [Walnut Creek CD](http://www.classiccmp.org/cpmarchives/ftp.php?b=cpm%2FSoftware%2FWalnutCD%2Fsimtel%2Fsigm%2Fvols000%2Fvol021 "/simtel/sigm/vols000/vol021") is a 'translation' by Paul H. Gilliam into Pascal/Z of the BASIC version of 'Wumpus 2' published in [More Basic Computer Games (1979)](https://www.atariarchives.org/morebasicgames/showpage.php?page=181).  Ideally it requires a terminal compatible with an ADM-3A, however if you don't have one and don't want to alter the source code, it should still work pretty well apart from throwing up the odd control character.  It is also works with 8080 processors.

Unfortunately, the copy on the Walnut Creek CD has three problems:
* 'CAVE3' is missing and to compound problems the BASIC listing published has an error for room 10, which I worked out should read `5,1,14`.
* The 'CAVE?' files are all using Unix line endings and therefore fail when read by the program.
* The text files are not terminated by a proper _end of file CTRL-Z (1Ah)_ character.

In addition 'CAVE5', the 'One Way Lattice', is different from the published version for some reason, but I have drawn the cave and it is a correct version, in that it has the same properties, even though the numbers are different.

I have therefore corrected these problems and have released [wumpus.lbr](/downloads/wumpus.lbr).

## Video of Hunt the Wumpus

Hunt the Wumpus can be seen being played on a C128 running CP/M in the video below.

<div class="youtube-wrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/CL9jo6yhXVM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
