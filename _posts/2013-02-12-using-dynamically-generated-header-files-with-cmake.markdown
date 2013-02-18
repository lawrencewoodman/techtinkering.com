---
layout: article
title: "Using Dynamically Generated Header Files with CMake"
tags:
  - Programming
  - Tutorial
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

Sometimes it can be useful to dynamically generate header files and include them from a C source file.  However, it can be a little difficult getting [CMake](http://www.cmake.org) to recognize when to generate the files and when to recompile the source files that include those headers.  What follows is a method to do this.

## Telling CMake to Generate the Header File
To generate the header file we need to create a _custom\_command_ which will run the command to generate the header file, when the file it is based on has changed. The following shows how to use the hypothetical `generatewordlistheader` command to create `wordlist.h` everytime `wordlist.txt` changes.

{% highlight cmake %}
add_custom_command(
    PRE_BUILD
    OUTPUT wordlist.h
    COMMAND generatewordlistheader wordlist.txt wordlist.h
    DEPENDS wordlist.txt
)
{% endhighlight %}


## Telling CMake When to Recompile
Next we need to tell CMake to recompile any source files which include the generated header file, when the header file has changed.  To do this we create a statically linked library, here called `poet`, that relies on the source files that include the header and the header itself.

{% highlight cmake %}
add_library(poet STATIC poet.c ${MyApp_SOURCE_DIR}/src/wordlist.h)
{% endhighlight %}

Finally we need to ensure that the statically generated library above is linked into the application.

{% highlight cmake %}
target_link_libraries(myapp poet)
{% endhighlight %}

## Full example
Using a fictional project called _MyApp_ we can see how this is put together.

{% highlight cmake %}
cmake_minimum_required(VERSION 2.6)
project(MyApp)
add_executable(myapp myapp.c)

add_custom_command(
    PRE_BUILD
    OUTPUT wordlist.h
    COMMAND generatewordlistheader wordlist.txt wordlist.h
    DEPENDS wordlist.txt
)

add_library(poet STATIC poet.c ${MyApp_SOURCE_DIR}/src/wordlist.h)

target_link_libraries(myapp poet)
{% endhighlight %}


## Conclusion
This isn't perfect but it does work.  Unfortunately CMake is an ugly, but very useful tool.  I'm sure there is a better way to do this and if anyone can think of a way, please leave a comment or email me.  Until then, this achieves what I and a number of other people have been trying to do.
