---
layout: article
title: "Connecting to a Remote Serial Port over TCP/IP"
tags:
  - Linux
  - Emulation
  - Retro
  - Tutorial
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

Most modern machines don't have a serial port as standard; you could use a USB to serial lead, however, if you have another machine available that does have a serial port you can access it remotely over TCP/IP.

## Using `ser2net` to Connect a Serial Port to a TCP port
[ser2net](http://ser2net.sourceforge.net/) listens to a TCP port and pipes data to and from a serial port via the TCP port.  It is configured by the file `/etc/ser2net.conf` and is run on the machine with the serial port that you want to make available over TCP/IP.  An example configuration file would look like this:

    3333:raw:0:/dev/ttyS0:115200,8DATABITS,NONE,1STOPBIT

This would tell `ser2net` to create a link between TCP port `3333` and `/dev/ttyS0`.  The serial port would be configured to 115200 baud, 8 data bits, no parity and 1 stop bit.

Once you have created the configuration file you can either start `ser2net` by running:

    $ ser2net

or if you have started it as a service you may need do something like:

    # /etc/init.d/ser2net restart

or if using `systemd`:

    # systemctl restart ser2net

From this point I'll refer to the machine with the serial port as `SerialMachine`.  If you connect to port `3333` on `SerialMachine`, whatever you send or receive to/from that port will actually be to/from the serial port on `SerialMachine`.

## Accessing a Remote Serial Port from DOSBox
A common use for this would to be to access a serial port form an emulator.  To access a remote serial port, that has been set up as above, from [DOSBox](/2008/10/24/using-dosbox-to-run-dos-games-and-applications/) you would need the following line in your `dosbox.conf` file:

    serial1=nullmodem server:SerialMachine port:3333

Now, whenever you use `COM1` from within DOSBox, you'll actually be using the serial port on `SerialMachine`.

## Using `socat` to Connect a Pseudo TTY to a Remote Serial Port
If the application you want to use doesn't know how to talk to serial ports over TCP/IP you can use [socat](http://www.dest-unreach.org/socat/).  This is an incredibly flexible utility and can even replicate much of the functionality of `ser2net`, however it is a little more difficult to use, hence the reason that I have combined the two utiltiies.  To create a psuedo tty device called `~/dev/ttyV0` and connect it to the remote serial port on `SerialMachine` run :

    $ socat pty,link=$HOME/dev/ttyV0,waitslave tcp:SerialMachine:3333

This will then allow you to specify `~/dev/ttyV0` as the device name in an application such as [minicom](http://alioth.debian.org/projects/minicom/).

## Where Now?
[ser2net](http://ser2net.sourceforge.net/) and [socat](http://www.dest-unreach.org/socat/) are available on most Linux distributions, but if yours doesn't provide a package then they are fairly easy to download and install from their home pages.  If you are not sure what to do with the new serial ports that you now have access to, why not hook-up a modem and see what BBS's are still around.
