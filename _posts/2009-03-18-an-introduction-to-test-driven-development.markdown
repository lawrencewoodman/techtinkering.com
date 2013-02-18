---
layout: article
title: "An Introduction to Test-Driven Development"
summaryPic: small_tdd.jpg
tags:
  - Test Driven Development
  - Debugging
  - Programming
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---
For the past 6 months I have been using Test-Driven Development (TDD) on a new project.  It has made such a difference to the quality of my code, that I feel I just have to share it's benefits with those who may not have heard of it. TDD reverses the normal order of testing as it requires developers to create automated unit tests _before_ code is written not after.  This takes some getting used to, and it can be quite difficult to resist the urge to write code first and then a test, but it really is essential to test first in order to gain the full benefits of TDD.  The beauty of this is that it allows you to concentrate on _what_ you want the code to do before you concentrate on _how_ to implement it.  

## Test-Driven Development Cycle

To use TDD, you need a unit testing framework such as <a href="http://www.junit.org/">JUnit</a> for Java.  The first thing to remember about TDD, is that you shouldn't write a single line of code without first creating a test for it.   Therefore, TDD is a constant cycle of creating tests, then writing the code to pass them.  Each test contains an assertion that is either true or false, so that a test can only pass or fail, thus enabling the tests to be fully automatic and not require developers to trawl through logs.   Development is therefore often carried out in the following way:

* **Add a test**

    Before implementing a new function or improvement to an existing function you should write just enough of a test to fail.  It should fail on the first run because you haven't implemented it.
	
*   **Run all tests and see if the new one fails**

    It is important that the new test fails to start with to make sure that it wouldn't blindly pass regardless.
*   **Write enough code to pass the new test**

    You should write **only** enough code to pass the test.  This reduces the chances of untested code.
*   **Run all the tests and see if they pass**

    If the test passes then you can add another test at step 1 ready for further code to be tested, or go to step 5 once you are happy that the implementation is complete and fully tested.
*   **Re-factor Code**

    If all the tests pass, then you can be confident that refactoring the code will not break it.  If it does break, then you can easily spot this and correct it.

## Tips for TDD
There are a number of tips that can help improve your success with TDD:

*   **Design for testability**

    This can make things much easier to test and can make the design much cleaner. 
*   **Don't break the encapsulation of your classes**

    It is important to respect the encapsulation of the class so that the tests are not reliant on the implementation details.  Therefore, you shouldn't test private methods directly, instead just thoroughly test the public methods and try to exercise the private methods as far as is needed through the public methods.  
*   **Create extra tests to find suspected bugs**

    While you can use a debugger to find bugs, it is important to complement this bug finding with extra unit tests to ensure that the bug doesn't come back and to improve the robustness of the tests.

## Benefits of TDD
TDD normally means that you end up producing a lot more code because of all the testing, but I have found that this dramatically improves the quality of the code and design.  I have also found there to be a definite speed improvement to my development work, because I am not spending so much time debugging.  In addition the following benefits are generally considered to be a hallmark of TDD: 
*	Helps you to concentrate on the expected behaviour of classes and their methods.  So that you can focus on how you would like them to work and be used, without worrying about the implementation details.
*	Gives you greater confidence to alter the implementations of the methods without breaking them or the programs using them.  This in particular is invaluable.  All too often we can be put-off cleaning up code or tweaking it to improve efficiency, because we are worried about introducing bugs.
*	Isolates bugs early rather than suffering from a mass of hard-to-locate bugs, thereby reducing the amount of time spent debugging.
* Makes project time planning easier as you are not so reliant on guessing the amount of time required at the end of a project to test and debug.
* The tests document extensively how to use the libraries,classes,functions,etc.
*	The tests can't get out of sync with the production code.

## Where Now?
Unfortunately I have found that information about Test-Driven Development on the internet is a little chaotic.  However, I do like <a href="http://www.testdriven.com">TESTdriven.com</a>, which has a good RSS feed and I particularly like their <a href="http://www.testdriven.com/modules/mylinks/">Web Links</a>, which has a great selection of articles.  I firmly believe that TDD can, with patience, improve virtually anyone's code, and certainly recommend that you give it a good go before making up your mind.
