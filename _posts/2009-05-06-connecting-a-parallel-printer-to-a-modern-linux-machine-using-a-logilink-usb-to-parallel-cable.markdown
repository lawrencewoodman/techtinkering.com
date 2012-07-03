---
layout: product_review
title: "Connecting a Parallel Printer to a Modern Linux Machine Using a LogiLink USB to Parallel Cable, D-SUB 25pin"
summaryPic: cable_usb_to_parallel.jpg
rating: 5.0
tags:
  - Retro
  - Review
  - Linux
  - Hardware
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
product:
  manufacturer: LogiLink
  model: "USB to Parallel Cable, D-SUB 25pin"
  amazon: "http://www.amazon.co.uk/gp/product/B000Q6JRHU?ie=UTF8&amp;tag=techtinkering-21&amp;linkCode=as2&amp;camp=1634&amp;creative=6738&amp;creativeASIN=B000Q6JRHU"
---

I have a number of older printers that I would like to connect to my modern machine, but have been unable to do so because my computer doesn't have a parallel interface.  After searching the internet for a review of a usb to parallel cable that works reliably with Linux, I pretty much drew a blank.  I then decided to look on Amazon and just give one a go.  Below is my brief review of the product that I found to work.  I hope that it is of some help to others who are looking for a similar cable.

I decided to purchase the <a class="amazonLink" href="http://www.amazon.co.uk/gp/product/B000Q6JRHU?ie=UTF8&amp;tag=techtinkering-21&amp;linkCode=as2&amp;camp=1634&amp;creative=6738&amp;creativeASIN=B000Q6JRHU" title="Buy from Amazon">USB Parallel Printer Port Cable 25 pin female socket</a> advertised on Amazon by Cablestar.  I went for the version with a female 25pin D-SUB on the end, as not all my printers have a standard Centronics interface.  My HP LaserJet 1100, for example, has a Mini-Centronics interface.  When the package arrived two days later I found that it was a _LogiLink USB to Parallel Cable, D-SUB 25pin_.  The package had the standard drivers for various flavours of Windows, but no drivers for Linux.  This came as no surprise, indeed I really would have been surprised if there had been drivers for Linux.

Now it was time to see whether my kernel (2.6.26 on Debian Lenny 5.01) would recognise this cable.  I plugged the cable into a free USB port on my computer and plugged my printer's parallel cable into the other end; straight away a printer port was created at `/dev/usb/lp0`.  All I had to do then was configure CUPS to see this printer, which was easily achieved through the `Printing` configuration option in the `Administration` menu of `Gnome`.

Even now I can't get over how easy this was, I was expecting at least a few little difficulties, but it really couldn't have been easier.  I therefore recommend this product unreservedly.
