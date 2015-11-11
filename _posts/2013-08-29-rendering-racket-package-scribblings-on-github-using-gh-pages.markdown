---
layout: article
title: "Rendering Racket Package Scribblings on Github Using gh-pages"
tags:
  - Racket
  - Tutorial
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

With the new package management system for Racket, there is a need to host documentation for the package somewhere.  Github allows you to host web pages, and hence a package's documentation, by putting them into the _gh-pages_ branch of your repository.  This can be a little awkward to do though, so this article will demonstrate an easy way to manage the process.

## Reorganising your Directory Structure
If your package was in `/home/you/dev/mypackage/`, you would want to reorganize it so that the contents of this directory is now in `/home/you/dev/mypackage/master/`:

{% highlight bash %}
$ cd /home/you/dev/mypackage/
$ mkdir master
$ mv * master/

# You may need to move additional hidden files to the
# ones in the line below
$ mv .g* master/
{% endhighlight %}


Now you can set up the `gh-pages` directory, where you will store the scribblings rendered as html:

{% highlight bash %}
$ mkdir gh-pages

# Clone your `master` branch into the `gh-pages` directory:
$ cd /home/you/dev/mypackage/gh-pages
$ git clone git@github.com:username/mypackage.git
$ mv mypackage/* .

# As above, you may need to move additional hidden files to
# the ones in the line below
$ mv mypackage/.g* .

$ rmdir mypackage

# Create a clean orphan branch: gh-pages
$ git checkout --orphan gh-pages
$ git rm -rf .
{% endhighlight %}


## Render the Package's Scribblings to gh-pages as html
To render the package's scribblings to html and store them in the `gh-pages` branch you can create a script called `/home/you/dev/mypackage/create-gh-pages.sh` which contains the following:

{% highlight bash %}
#!/usr/bin/env sh

scribble +m --dest-name index.html --dest gh-pages/ --redirect-main  http://download.racket-lang.org/docs/5.3.6/html/ master/collection/scribblings/collection.scrbl
{% endhighlight %}

Where `5.3.6` is the version of Racket's documentation that you want to cross reference and `collection` is the name of the collection within the package that you want to render.

You will need to make the script executable with:

{% highlight bash %}
$ chmod +x create-gh-pages.sh
{% endhighlight %}

Now you just need to run it, add the rendered files into the `gh-pages` branch in the normal way and push them to github:

{% highlight bash %}
$ cd /home/you/dev/mypackage/
$ ./create-gh-pages.sh
$ cd /home/you/dev/mypackage/gh-pages
$ git add *.html *.css *.js
$ git commit -am "Import project into repo"
$ git push origin gh-pages
{% endhighlight %}

## Accessing the Documentation
You will now be able to access the rendered documentation at:
  `http://username.github.io/mypackage/`

You may want to point to it from your github repository's `README`, if you have one, as well as set the repository's homepage to the url.  Finally you can define `homepage` within a collection's `info.rkt` file to point to the url.

## Where Now?
This should be enough to get you started and there are may variations on this that you could try.  You may also want to automate the process of generating the scribblings with a Makefile, or perhaps using a git hook.
