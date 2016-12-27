---
layout: article
title: "Introducing TextPix v0.1 - A program to convert an image into a character set and text mode screen data"
summaryPic: small_textpix_eye.jpg
summaryTitle: "An example image reduced by TextPix"
tags:
  - Conversion
  - Graphics
  - Images
  - Retro
  - TextPix
  - Text mode
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
I have today released <a href="https://github.com/LawrenceWoodman/TextPix/blob/master/README.md" title="The TextPix README">TextPix</a> v0.1  This is a program to take an image and convert it into a redefined character set and the associated text mode screen data referencing that character set.

The program came about because I wanted to be able to load images on the Jupiter Ace, but the Ace has no way of allowing you to control individual pixels on the screen.  The best that you can do is redefine the character set and then use those redefined characters to display your image.  This does however present a problem as the Ace only allows you 128 characters plus their inverse in the character set.  Since the screen contains 32x24=768 characters, there would have to be massive repetition in the image to be able to use only 128 characters plus their inverse to display the image.  TextPix therefore tries to find similar sections of the images to replace other similar sections so that the number of characters needed in the character set can be brought down to 128.

<img src="/images/posts/eye-open.jpg" title="The source image"/>

The program is only in development at the moment and not ready for general use.  However it does achieve its basic aim of creating a redefined character
set and a text mode screen that will approximate a source image.  To the right can be seen a full colour image that was used in the screenshot below.

<img src="/images/posts/textpix-v0.1-screenshot.jpg" title="Screenshot of TextPix v0.1"/>

The screenshot shows two black and white images: The one on the left is the source image dithered to two colours and altered to the correct size and the image on the right is the result of TextPix's image reduction.  The results aren't always brilliant, but it certainly shows that a lot can be done with the concept.  This give me confidence that it is worth pursuing and that futher advances can be made.

Since first writing the program, I have decided to make it more generic so that it will work on other machines.  Ultimately I envisage that this method could be used to create small movies in text mode.


<h2>Further Information</h2>
As mentioned above, the program is not ready for general use, however more details can be found in the TextPix <a href="https://github.com/LawrenceWoodman/TextPix/blob/master/README.md">README</a>.  If you would like to contribute to the project then I would particularly love to hear from you.
