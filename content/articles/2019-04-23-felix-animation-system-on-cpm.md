In 1979 the University of Tennessee/Knoxville's Computer Science Department released [Felix v2.1](http://www.classiccmp.org/cpmarchives/cpm/Software/WalnutCD/simtel/cpmug/cpmug035.ark "cmpug035.ark") for CP/M, which is available on the Walnut Creek CD.  It aimed to provide a basis for computer animation experiments and projects for education and hobbyist use.

<img src="/img/articles/felix_bee.png" class="img-left" style="width: 256px; clear: right;" title="BEE#.FEX In Action Using Felix">

The system used an early graphics card for S-100 bus computers called the [Cromemco Dazzler](https://en.wikipedia.org/wiki/Cromemco_Dazzler) to display the animations on a television screen.  The Dazzler was released in 1976 and could display a maximum resolution of 128x128 in monochrome or 64x64 using 8 colours with or without intensity.

Felix uses a VM to display and control the animations with the hope of creating a portable animation system across computing platforms.  The animations are created in a form of assembly language targeted at the Felix VM which is assembled using the `FASM` command to produce a `.FEX` file which is then run using the `EXEC` command.

An example file called `BEE.FAS` is included in the archive and listed below:

<br />

```` nasm
; 8 SEPT 79 - MOSHELL
;
; BLOOMING FLOWER; BEE LANDS,FLIES AGAIN.BIRD
; COMES ALONG AND EATS BEE.
;
SPEED	EQU	0
GROUND	EQU	0
STEM	EQU	1
LEFTPETAL EQU	2
RIGHTPETAL EQU	3
BEE	EQU	4
BEEPATH	EQU	5
B2PATH	EQU	6
BIRD	EQU	7
BIRDPATH EQU	8
;
	DELAY	SPEED
	ONLIST	2,STEM,GROUND
	MOVE	15,.COUNT
;
;FIRST THE PLANT GROWS AND BLOSSOMS.
;
STEMLOOP:	FLY	STEM,0,1
	SHOW
	SUB	.COUNT,1,.COUNT
	JNZ	STEMLOOP
;
	BACKGRND	STEM
	ONLIST	4,LEFTPETAL,RIGHTPETAL,STEM,GROUND
	MOVE	5,.COUNT
	DELAY	150
;
PETALOOP:BACKGRND	LEFTPETAL
	BACKGRND	RIGHTPETAL
	SPIN	LEFTPETAL,-1
	SPIN	RIGHTPETAL,1
	SHOW
	SUB	.COUNT,1,.COUNT
	JNZ	PETALOOP
;
	CALL	PAUSE
	ONLIST	1,BEE
;
;NOW A BEE WANDERS ACROSS THE SCENE,SETTLES ON FLOWER.
;
BEELOOP:PATH	BEE,BEEPATH
	SHOW
	JNZ	BEELOOP
;
	CALL	PAUSE
	ONLIST	2,BEE,BIRD
;
;NOW THE BEE LEAVES THE FLOWER,MEETS BIRD.
;
B2LOOP: PATH	BIRD,BIRDPATH
	PATH	BEE,B2PATH
	SHOW
	JNZ	B2LOOP
;
	ONLIST	1,BIRD	;BEE DONE BEEN ET.
;
; BIRD NOW FLIES AROUND THE SCREEN FOREVER.
;
BIRDLOOP:PATH	BIRD,BIRDPATH
	SHOW
	JUMP	BIRDLOOP
;
;- - - - - - - - - - - - - - - - - - - - -
;
PAUSE:	DELAY	250
	MOVE	5,.COUNT
PLOOP:	SUB	.COUNT,1,.COUNT
	JNZ	PLOOP
	DELAY	SPEED
	RETURN
;
COUNT:	DB	0
;
	END
````

<br />

You can see a couple of animations using Felix in the following video.  It demonstrates Felix using [z80pack](/articles/emulating-a-cpm-system-with-z80pack/) to emulate an IMSAI 8080 with a Dazzler, running CP/M 2.2.  Unfortunately, I'm not able to fully test Felix because the emulator doesn't emulate the required analog-to-digital converter to use the joysticks.  However, it was fun to play with and I think it's nice to see the system in action.

<div class="youtube-wrapper">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/QdmXZ0U9XHg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
