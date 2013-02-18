---
layout: article
title: "How to File Good Bug Reports"
summaryPic: small_bug.jpg
tags:
  - Debugging
  - Open Source
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
The real advantage of Open Source software is that many people from all around the globe can work to make it better.  This means that bugs can be detected and often fixed much more quickly than with closed source software.  The software does tend to be run on lots of platforms however, so there is no way that a developer can test their software on all the configurations possible, therefore it is important that bug reports are filed accurately and promptly.

Please don't assume that someone else has reported the bug, or that it will get noticed and fixed without your reporting it.  It doesn't matter how small you believe the bug to be, if it is a bug, it is worth reporting; especially as it could point to wider problems that are going unnoticed.  By filing a bug report you are contributing in a small way to the quality of the software, and you end up with software that works properly for you.  So if you find a bug, why not report it, and help you and your fellow man.

## Preliminaries

* If you think the problem may be occurring because you are unsure of the proper use of the software, then check it's man pages, faqs and documentation.  These may come with it, but it is also worth looking on the sites homepage.

* Be clear in your mind about what you are filing the bug for.  Are you filing it for the version of a package in you current distribution, or are you filing it for a version of the software available at it's homepage.  If the latter is the case, try downloading the latest version from the software's homepage.

* Go to the either the software's bug tracker via it's homepage or to your distribution's bug tracker via it's homepage.  Check thoroughly through the existing bugs to make sure you are not refiling an existing bug.  If the bug does exist, see if you can shed some more light on the bug.

## Filing the Bug Report
The mechanics of filing a bug report are different for each piece of software and for each distribution.  While there is some commonality between them, it is worth looking on the relevant sites to see how the software package/distribution likes it to be done.  There are, however, some guidelines below that should be relevant to which ever method of bug reporting is used.

* Provide precise relevant information.  Make it clear what distribution, architecture, and version of the software you are using.  Say when the problem happens, and what you do to reproduce it.  It is also worth noting any workarounds that you may have found.

* Be as clear as you can.  Remember that things that seem obvious to you, may not do to the person reading your bug report.

* Only file one bug per report.  If you think that it relates to another bug, but is not the same as another bug, then you can refer to that other bug report in your report.

* Separate fact from speculation and make this clear in your report.

* If you have a big file that sheds more light, such as a large _backtrace_ log or _strace_ output, it is probably better to send this in a follow-up message.  Please review any additional data you send as it may contain sensitive information.

## Two Examples That Benefited Me Directly
I'm not saying that the following examples are usual, but this does happen sometimes.  This could be seen as an added incentive to file those bug reports promptly.

### epiphany-webkit
The bug report was filed with the Debian distribution.  I was contacted, installed an experimental library, and the problem was fixed within half an hour.

### twitux
The bug report was filed with the Debian distribution.  After a few emails back and forth and my providing various traces.  The problem was located and a workaround found after a fortnight.

## Is There Anything Else I Could do?
Bug reporting and fixing isn't glamorous, but it arguably provides more benefit to end users than adding new features.  There are a number of things that you can do depending on your skill level.

* Look further into the bug yourself.  Try to see if you can isolate exactly when it is happening, and what is causing it.  Become familiar with tools such as <em>strace</em>, <em>ldd</em> and <em>gdb</em> to help you.

* Lots of the projects out there are crying out for more help with handling bugs.  The levels of expertise vary from people who discard obviously silly reports and escalate valid reports, to more in-depth bug isolation and repair work.  If you think you could help, then there are many projects that would love to have you aboard.

* If you are a programmer, try downloading the source code and see if you can identify the problem in the code.  Perhaps, you could even find a patch for the problem and submit that.

Happy Bug Hunting!
