---
layout: article
title: "Dealing Sympathetically with Legacy Code"
tags:
  - Programming
  - Legacy Code
  - Retro
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
I have often noticed programmers getting worked up about the legacy code they are maintaining.  I know it is annoying having to wade through poor code, or
worrying about making changes for fear of unexpected side-effects.  However, it is important to see the code for what it is and in the context of when it was written.  Coding styles change, programmers change.  What a programmer did then, they may not do today.  Once this is accepted, I find the code base is accepted.

## What is legacy code?
I define legacy code as code that is no longer maintained, or that is frightening to work on because it not fully understood.  Typically this code has no tests and is hard to test because it hasn't been written to be tested.

## Preparing the environment
Before you can work effectively with the code, you need to ensure the environment is conducive.  This can be a big hurdle if the build tools or environments  themselves are outdated or poorly understood.  I have repeatedly come across poor build automation so that builds took longer and were more complicated than should have been the case.  Improving this can make a huge difference to the speed with which you can make a change and test it.

## Exploring the code base
To make changes to the code you need to take the time to explore and properly understand it.  Do this by adding temporary comments, refactoring, adding tests and using your revision control software to create branches where you can take the code apart and test your understanding.

## Making style changes
Coding styles do change and every programmer has their own preference.  Don't be too critical of coding styles that were typical when the code was written and don't judge the code by today's standards.  Try to fit in with the coding style of a file.  A mixture of styles in a file can be very confusing and makes it much harder to work with.  If you feel that you can't adapt to the style, then change it throughout the file or start the new style in a separate file.  When you do make style changes, try to put them in a separate commit, so functional changes and style changes are distinct.  This helps future maintainers of the code. 

Elements of coding styles that you may want to consider seriously before changing include:  tabs vs spaces, camel caps vs snake case, K&R declarations vs prototypes, procedural vs object-orientated paradigm.

# Comments lie
Comments can be useful to explain complex code or dependencies.  However, they are often out of step with the code and therefore can confuse.  Think seriously before putting comments in code.  I often use them as I am exploring code to understand it.  Once I have gained the understanding that I was looking for, I will refactor the code and remove virtually all the comments.  Less is more as far as comments go.

## Refactoring
Rather than using comments to explain code, I would much rather refactor the code so that the variables and functions make it clear what is happening.  Functions can be tested and maintained more easily and if your understanding of the code changes, you are more likely to change the functions to suit, this may not be the case with comments.  For more on this take a look at: [Refactoring: Arm Yourself in the War Against Useless Comments](/2012/04/26/refactoring-arm-yourself-in-the-war-against-useless-comments).

## Testing
Adding tests to code can be the most useful change that you make.  It will often feel difficult if the code wasn't designed to be tested, but will reap rewards in terms of understanding and confidence in the code.  Think of good tests as a gift to yourself and those that maintain the code after you.

## Remember the next guy
Any changes that you make should improve the maintainability of the code not add to the technical debt.  You may not be the last person to work on this code, so please remember the next guy.
