---
layout: article
title: "Using C-Kermit to Exchange Files With Telnet BBS's"
tags:
  - Linux
  - BBS
  - Retro
  - Tutorial
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

Most BBSs that are still running now do so via telnet.  In many ways this is great as it allows people from all around the world to access a BBS as if it were local to them.  The problem comes though, when you want to upload or download a file to/from the BBS.  Most telnet clients don't make this easy.  Here I show how to use [C-Kermit](http://www.kermitproject.org/ck90.html) as a telnet client and how to upload/download files with it.

## Installing and Configuring _C-Kermit_
You need to ensure that you have `ckermit` and `lrzsz` installed.  The first is a _C-Kermit_ implementation and the latter provides tools for zmodem/xmodem/ymodem file transfer.

If you are only using C-Kermit to Connect to Telnet BBS's, you'll probably want to put the following lines in your `~/.mykermrc` file, otherwise you will need to enter them from the kermit prompt.

    set file type binary
    set telopt kermit refuse refuse
    set protocol zmodem

The `set telopt...` line is there because Synchronet, which many BBS's use, doesn't handle RFC2840 properly.  The `protocol` above is set to `zmodem`, in theory the _kermit_ protocol should have been a better choice, but for some reason I often end up with files missing parts when I use it with telnet BBS's.

## Connecting to a Telnet BBS
_C-Kermit_ can create a telnet connection by using the `-J` switch:

    $ kermit -J somebbs.example.com

If you are connecting to a BBS that relies on colour ANSI graphics, you will want to ensure that your terminal is set up to emulate this.  To do that read: [Getting Colour ANSI Emulation to Work Properly When Connecting to a BBS With Telnet Under Linux](/2010/02/14/getting-colour-ansi-emulation-to-work-properly-when-connecting-to-a-bbs-with-telnet-under-linux/).

## Downloading Files
When you want to download, just start the download from the BBS, select `zmodem` if possible and _C-Kermit_ will automatically start `rz` to download the file.  The file will be put into the directory that _C-Kermit_ was started in, unless you have changed the working directory using the `cd` command from the kermit prompt.

## How to Upload
Uploading is a little more complicated and relies on kermit's mode system.  The process is as follows:
1. Start the upload at the BBS end, remembering that your transfer protocol was set to _zmodem_ above.
2. Once started, press the escape key (<em>CTRL+\</em>) then `c` to get back to the kermit prompt.
3. Use the `send` command to send the file.  To help find the file you want to send you can use the `ls` and `cd` commands.  So to send `afile.bin` use:

    <pre><code>C-Kermit> send afile.bin</code></pre>

4. Reconnect to the telnet session using the `connect` command.

## Where Now?
C-Kermit has many features, so it is worth looking at its man pages.  You will find that some BBS's work better with it than others, but hopefully this article will help you get the most out of BBSing from Linux.
