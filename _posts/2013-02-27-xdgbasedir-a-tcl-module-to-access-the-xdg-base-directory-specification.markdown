---
layout: article
title: "xdgbasedir: A Tcl Module to Access the XDG Base Directory Specification"
tags:
  - Programming
  - Tcl/Tk
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

Unix has traditionally lacked a consistent way of storing user specific and system wide configuration and support files.  This has lead to a mess of dot files in a user's home directory and other associated files being all over the file system.  The [XDG Base Directory Specification](http://standards.freedesktop.org/basedir-spec/latest/index.html) describes a simple and clean way to locate these files across all Unix-like systems.  The `xdgbasedir` module allows you to easily access this specification from Tcl.

## Why Use the XDG Base Directory Specification?
By storing an applications files using this spec. it makes it much easier for the user to find the files associated with your application so that they can edit and back them up.  For the application, it makes it much easier to work with files in a consistent manner on whichever Unix platform it is running.

 Ultimately the spec. allows you to turn this:

    .                     Downloads           .lives            .scummvm
    ..                    .fontconfig         .lives-dir        .scummvmrc
    .android              .FontForge          livestmp          .sitecopy
    .aptitude             .gcjwebplugin       .local            .sitecopyrc
    archive               .gconf              .lyrics           .slrnrc
    .avm                  .gconfd             .mbox             .ssh
    .balazar              .gegl-0.0           .mcoprc           .synaptic
    .bash_history         .gem                .mess             .tdfsb
    .bash_logout          .gitconfig          .metacity         Templates
    .bash_profile         .gitk               Music             .themes
    .bashrc               .gnash              .nexuiz           .thumbnails
    .bochsrc              .gnome              .openMSX          .tremulous
    .bogofilter           .gnome2             .openoffice.org   .tsclient
    .bundler              gpodder-downloads   .orbit            .tvtime
    .cache                .gramps             .pan2             Video
    .Catapult             .gtkrc-1.2-gnome2   .pcmanx           .vim
    .cgobanrc             .gtwitter           Pictures          .viminfo
    .civserver_history    .gvfs               .pingus           .vimrc
    .config               .gvimrc             Podcasts          .vlc
    .conky                .hplip              Public            .w3m
    .conkyrc              .ICEauthority       .purple           .wapi
    .corewars             .icons              .q3a              .wmii
    data                  .inkscape           .qt               .wmii-3.5
    .dbus                 .irb-history        retro_archive     .Xauthority
    Desktop               .jigdo-lite         retro             .xawtv
    dev                   .libreoffice        rtb               .xchat2
    .dmenu_cache          .liferea            .rvm
    .dmrc                 .lincity            .sane
    Documents             .liquidwarrc        .scorched3d

Into this:

    .         .config   Documents           Music      retro
    ..        data      Downloads           Pictures   retro_archive
    archive   Desktop   gpodder-downloads   Public     Templates
    .cache    dev       .local              Podcasts   Videos

## How Should I Locate Files Using the Specification?
A brief explanation of the spec. follows, for more look at the [XDG Base Directory Specification](http://standards.freedesktop.org/basedir-spec/latest/index.html) recommended by [freedesktop.org](http://www.freedesktop.org).

The specification uses six environmental variables to locate files.  These are:

<table class="neatTable">
  <tr><th><code>$XDG_DATA_HOME</code></th><td>For user-specific data files.</td></tr>
  <tr><th><code>$XDG_CONFIG_HOME</code></th><td>For user-specific configuration files.</td></tr>
  <tr><th><code>$XDG_CACHE_HOME</code></th><td>For user-specific non-essential data.</td></tr>
  <tr><th><code>$XDG_RUNTIME_DIR</code></th><td>For user-specific runtime files.</td></tr>
  <tr><th><code>$XDG_DATA_DIRS</code></th><td>A list of directories, in order of preference, which should be searched for data files.</td></tr>
  <tr><th><code>$XDG_CONFIG_DIRS</code></th><td>A list of directories, in order of preference, which should be searched for configuration files.</td></tr>
</table>
<br />

For each directory or for each directory in the list of directories (in the case of the environmental variables ending with `_DIRS`), you would normally append the name of your application.  So for example if the `$XDG_DATA_HOME` variable returned `~/.local/share`, and your application was called `myapp`, you should look in `~/.local/share/myapp/` for that application's user-specific data files.


## The _xdgbasedir_ module for Tcl
To ease working with the XDG Base Directory Specification from Tcl, I created the [xdgbasedir](https://github.com/LawrenceWoodman/xdgbasedir_tcl) module.

To access the XDG directories you would typically specify the subdirectory that these directories will be relative to. The subdirectory is normally the name of the application, `myapp` in this example:

{% highlight tcl %}
package require xdgbasedir

puts "XDG_DATA_HOME: [XDG::DATA_HOME myapp]"
puts "XDG_CACHE_HOME: [XDG::CACHE_HOME myapp]"
puts "XDG_CONFIG_HOME: [XDG::CONFIG_HOME myapp]"

puts "XDG_RUNTIME_DIR: [XDG::RUNTIME_DIR myapp]"
puts "XDG_DATA_DIRS: [XDG::DATA_DIRS myapp]"
puts "XDG_CONFIG_DIRS: [XDG::CONFIG_DIRS myapp]"
{% endhighlight %}

The `XDG` procs ending in `_DIRS` return a list of directories in order of preference.

## Getting _xdgbasedir_
You can download `xdgbasedir` from the [archive](https://github.com/LawrenceWoodman/xdgbasedir_tcl/tags) page on github, and read the installation instructions in the [README.md](https://github.com/LawrenceWoodman/xdgbasedir_tcl/blob/master/README.md) file.
