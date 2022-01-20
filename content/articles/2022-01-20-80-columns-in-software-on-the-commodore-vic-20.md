If you have good eyesight, a well-tuned display and patience it is possible to use 80 columns in software on the VIC-20.  This is really just an experiment but considering the limitations of the Vic I think the results are quite good.  While it looks hard to decipher to start with, over time it becomes easier to use.

## The 80 Column Character Set

<img src="/img/articles/vic20_80_column_charset.png" class="img-right" style="width: 500px; clear: right;" title="The 80 column character set for ASCII 33-126">

In order to be able to display 80 columns on the Vic I have created a 2x8 bit character set.  The  characters can be seen in the image which is displaying ASCII characters 33-126.

I have taken a number of steps to help optimize the character set so that each character is as distinct as possible.  The uppercase and lowercase letters are folded into a single case and use mainly lowercase letters with a few uppercase letters where they stand out more.  I have used descenders for some letters such as 'p', 'q' and 'y'.  The non-alphabetic characters make use of the full-height of the characters to help make them more distinct, this is particularly important for the numeric characters.

While designing the characters I was careful to consider what they would look like next to other letters - this can be seen with the 'h', for example, which if placed next to another letter will invariable look like the final down leg is present.

## 80 Column Software Routines

The code for this is in the [display80_vic20 repo on GitHub](https://github.com/lawrencewoodman/display80_vic20) and contains the routines to display the text in 80 columns along with some test programs.

Since the font is 2x8 this means that four characters fit side-by-side in the space of one 8x8 Vic character and therefore if we use twenty Vic columns of text we can get eighty columns across. To help increase our ability to see the character boundaries the colour of the characters alternates between blue and black every fourth eighty column character.

<img src="/img/articles/vic20_80_column_scrollup_80_mode.png" class="img-right" style="width: 100%; clear: right; margin-bottom: 2em;" title="Displaying some text using 80 columns">


For comparison the text being displayed in the image is as follows.

```
80 columns on the Commodore VIC-20!

Supports Newline (software definable), Backspace, Tabs to next eighth column and
 ASCII 32-126 with case folded into a single case.  The fonts are 2*8 and uses h
eight and descenders to help differentiate the characters.  The numbers are tall
er for the same reason.

The standard text mode is 80*22 with the ability to switch to 20 column mode whi
ch views the 80 column screen through a movable window using the standard 8*8 fo
nt.

The alphabet:
  a b c d e f g h i j k l m n o p q r s t u v w x y z
  A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
The numbers:
  0 1 2 3 4 5 6 7 8 9
The rest:
  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~

Where there's a will there's a way!
```

### 20 Column Movable Window

<img src="/img/articles/vic20_80_column_scrollup_20_mode.png" class="img-right" style="width: 500px; clear: right;" title="Displaying some text using a 20 column window">

The software also supports switching to a 20 column mode which uses a movable window to display a quarter of the 80 column screen width.  In the test programs I have used the function keys: F1, F3, F5 and F7 to easily move the window between quarters of the screen width.  80 column mode is accessed using F2.  The 20 column mode is particularly useful to not only clarify certain character combinations which can look similar but also to see which characters are uppercase and which are lowercase.


## Video

The following video shows the 80 column text mode in action.

<div class="youtube-wrapper">
<iframe width="560" height="315" src="https://www.youtube.com/embed/iEJGE7RatFU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>


## Other Text Modes

This article is one of a number articles covering different text modes for the Vic.  The others may also be of interest.

* [64 Column Text Mode on the Commodore VIC-20](/articles/64-columns-sideways-on-the-commodore-vic-20/)
* [40 Columns in Basic on the Commodore VIC-20](/articles/40-columns-in-basic-on-the-commodore-vic-20/)
