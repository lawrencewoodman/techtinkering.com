---
layout: article
title: "Compiling a Tcl Script into an Executable"
tags:
  - Programming
  - Tcl/Tk
  - Tutorial
  - C
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

Locating Tcl scripts to load from an executable can be awkward if you want to make your program cross-platform.  An easier way is to compile a Tcl script directly into the executable and let that script find any other scripts needed.  This is particularly relevent as so many programs just use a single Tcl script to create a Tk GUI and therefore this should be as pain free as possible.

Any easy way around this is to turn your Tcl file into an array that can be included from your source file.  This article explores how to do this with Tcl and C.

## Converting the Tcl Script
To include the Tcl script it needs to be converted into a C array.  This can be done from Unix with the `xxd -i` command.  So to convert `my.bin` to `my.bin.h` you would run:

{% highlight bash %}
$ xxd -i my.tcl my.tcl.h
{% endhighlight %}

If don't have access to `xxd`, you can use [bin2c](https://github.com/LawrenceWoodman/bin2c) downloadable as an archive from [here](https://github.com/LawrenceWoodman/bin2c/tags).  To do as above with `bin2c`:

{% highlight bash %}
$ tclsh bin2c.tcl my.tcl my_tcl my.tcl.h
{% endhighlight %}

This will create a file similar to the following:
{% highlight c %}
unsigned char my_tcl[] = {
  0x70, 0x75, 0x74, 0x73, 0x20, 0x22, 0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x2c,
  0x20, 0x77, 0x6f, 0x72, 0x6c, 0x64, 0x21, 0x22, 0x0a, 0x70, 0x75, 0x74,
  0x73, 0x20, 0x22, 0x49, 0x20, 0x68, 0x6f, 0x70, 0x65, 0x20, 0x79, 0x6f,
  0x75, 0x20, 0x6c, 0x69, 0x6b, 0x65, 0x64, 0x20, 0x74, 0x68, 0x69, 0x73,
  0x20, 0x61, 0x72, 0x74, 0x69, 0x63, 0x6c, 0x65, 0x20, 0x66, 0x72, 0x6f,
  0x6d, 0x3a, 0x20, 0x68, 0x74, 0x74, 0x70, 0x3a, 0x2f, 0x2f, 0x74, 0x65,
  0x63, 0x68, 0x74, 0x69, 0x6e, 0x6b, 0x65, 0x72, 0x69, 0x6e, 0x67, 0x2e,
  0x63, 0x6f, 0x6d, 0x22, 0x0a
};
unsigned int my_tcl_len = 89;
{% endhighlight %}

## Loading the Tcl Script
In the example below you can see that `my.tcl.h` has been included into the function which will load the script.  The array created above is then evaluated by `Tcl_EvalEx()` using the created array: `my_tcl`, and its associated length variable: `my_tcl_len`.
{% highlight c%}
#include <tcl.h>

static Tcl_Interp *interp;

int
Script_init()
{
  // Include my.tcl which has been converted to a char array using xxd -i
  #include "my.tcl.h"

  interp = Tcl_CreateInterp();
  if (Tcl_Init(interp) == TCL_ERROR) { return 0; }

  if (Tcl_EvalEx(interp, my_tcl, my_tcl_len, 0) == TCL_ERROR ) {
    fprintf(stderr, "Error in embedded my.tcl\n");
    fprintf(stderr, "%s\n", Tcl_GetStringResult(interp));
    return 0;
  }

  return 1;
}
{% endhighlight %}


## Conclusion
This process makes it much easier to distribute an executable.  Once an initial Tcl script has been loaded, you can use something like the [xdgbasedir](https://github.com/LawrenceWoodman/xdgbasedir_tcl) module to easily locate other scripts for the program.  To automate this process, take a look at [Using Dynamically Generated Header Files with CMake](/2013/02/12/using-dynamically-generated-header-files-with-cmake).

