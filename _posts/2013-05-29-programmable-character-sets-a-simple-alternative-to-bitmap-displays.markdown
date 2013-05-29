---
layout: article
title: "Programmable Character Sets: A Simple Alternative to Bitmap Displays"
tags:
  - Retro
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

Programmable or reconfigurable character sets were a simple alternative to fully bitmappable displays.  The main driving force behind their creation was a desire to keep the cost of computers low: RAM was expensive and bitmappable displays need more complex hardware.  Programmable character sets were a half-way house between the preceding extended character sets, which contained most of the 7-bit ASCII characters plus extra graphic characters, and bitmappable displays.

By creating your own character set you could create different fonts, software sprites and even simulate a bitmap.  They gave a much greater degree of control than a fixed extended character set at the same time as reducing the cost of the computer.  With careful planning you could create very quick and compact code because a single write to memory would allow you to output a character which would typically contain a group of 8x8 pixels.  Two machines that really captured how well this could be done are the Commodore Vic-20 and the Jupiter ACE.


## The Commodore Vic-20
The unexpanded machine had 5KB of RAM and the character set would typically approach the screen memory.  Therefore if you wanted to reduce the memory taken up by the character set to just 64 or 128 characters this could easily be done by overlapping the screen memory.  In addition this could be reduced further or used more flexibly by storing other data or code in the character set memory.

A lot of Vic-20 software was distributed as cartridges, which meant that additional character sets could be stored in ROM and used as needed.  This further enhanced the power of the method.

The Vic-20 was quite a flexible machine; you could change the character set as the raster line moves down the screen, giving additional possibilities;  you could even simulate a bitmap display by using 8x16 characters, but this would of course use twice as much memory so wasn't suitable for the unexpanded Vic-20.

Below you can see how much memory various configurations use:

    Text Screen + 256 8x8 Character set + colour attributes:
    (22x23) + (256x8) + (22x23) = 3060 bytes

    Text Screen + 128 8x8 Character set + colour attributes:
    (22x23) + (128x8) + (22x23) = 2036 bytes

    Text Screen + 64 8x8 Character set + colour attributes:
    (22x23) + (64x8) + (22x23) = 1524 bytes

    176x184 nearest bitmap equivalent + colour attributes:
    (176x184/8) + (22x23) = 4554 bytes


    Text Screen (Simulated bitmap) + 8x16 Character set + colour attributes:
    (23x11) + (256x16) + (23x11) = 4602 bytes

    184x176 nearest bitmap equivalent + colour attributes:
    (184x176/8) + (23x11) = 4301 bytes

You can see that the simulated bitmap takes more memory than a real bitmap, but if you can can work with the 256, 128 or 64 programmable characters you make a saving of 1494, 2518 or 3030 bytes respectively.  On a 5KB machine this is a considerable saving.

<img src="/images/posts/vic20-jetpac.png" title="JetPac for the Vic-20" />

## The Jupiter ACE
The ACE's character set had 256 characters where the first 128 were definable and the second 128 were the inverse of the first 128.  Unlike the Vic-20, the ACE's video sub-system had its own 2KB of SRAM used to store the text display screen and character set.  Therefore a programmable character set didn't effect the 1KB of RAM that the machine had.  The ACE's screen was 32 columns by 24 rows using an 8x8 font.  This naturally meant that a simulated bitmap of the whole screen wasn't straightforward, however in practise with a good design the 128+inverse characters can be enough.

Below you can see a comparison of the RAM used by the character set vs a bitmap equivalent.  The programmable character set saves 4352 bytes.

    ACE Text Screen + 128 8x8 Character Set:
    (32*24) + (128x8) = 1792 bytes

    ACE 256x192 bitmap equivalent:
    256x192/8 = 6144 bytes

A bitmap image can often be made to fit into the restricted character set by matching and altering tiles to conform to the 128+inverse characters.  Below you can see a picture that has been converted using [TextPix](/2010/04/16/introducing-textpix-v0-1/) so that it can be displayed using the ACE's programmable character set.

<img src="/images/posts/xace-textpix-v0.2-screenshot.jpg" title="Bitmap converted to ACE's character set using TextPix" />

## Other Machines
There were other machines that used a programmable character set such as the Commodore 64 and Sinclair Spectrum, but these machines also had access to a bitmappable display.  Where these machines used the programmable character set instead of a bitmappable display, this was mainly to reduce RAM usage, speed up certain routines and make things simpler.

## Alternative Low RAM Displays
Beyond the extended and programmable character sets already mentioned, there were two other notable examples of low RAM displays:

Vector Graphics
: To create a picture on this type of display you had to specify the points of the vector and then keep redrawing them to keep the display stable.  This required no RAM to hold the picture, but did require a special Vector monitor and therefore increased the cost as it couldn't be used with a TV.

Atari 2600 TIA
: The [Television Interface Adapter](http://en.wikipedia.org/wiki/Television_Interface_Adapter) was designed as a RAM-less way of outputting graphics to a Television.  Instead of using a framebuffer in RAM to create a bitmappable display, the TIA chip was controlled through a few registers which provided five movable graphic objects and a static playfield object, which you could change for each raster line.


## Impact
You should now see why the Vic-20, Jupiter ACE and other machines used a programmable character set instead of a bitmappable display.  Both of these machines seemed to get along just fine like this and importantly it kept the cost down so that more people could afford them.

