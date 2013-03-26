---
layout: article
title: "Using Netcat to Create ad hoc Links Between Applications or Machines"
tags:
  - Tutorial
  - Linux
author:
  name: Lawrence Woodman
  url: /profile/lawrencewoodman/
licence: cc_attrib
---

[Netcat](http://nc110.sourceforge.net/ "The Netcat homepage") is a simple Unix utility which reads and writes data across network connections using the TCP or UDP protocol.  It is often described as the "Swiss-army knife for TCP/IP" because of its flexibility and is often used to debug and investigate network connections directly from the command line or through scripts.  This article shows how easy it is to form simple connections between applications or machines for those times when it isn't worth setting up something more elaborate.

Netcat is normally executed by running `nc`.  The following examples will all use port `3333` and two switches in particular: `-l` to listen and `-p` to specify a port.  Be aware that while the examples given can be very useful, the communication is unencrypted and could lead to security problems if you are not careful.

### A Simple Chat Application
To create a simple chat application run the following commands on two machines and then start typing.  Each time you press return a line will be sent to the other machine.  Press `^C` to quit.

On the server

    $ nc -l -p 3333

On the client

    $ nc server.example.com 3333

or

    $ telnet server.example.com 3333

### Remote Control an Application
If you don't want to setup an ssh or telnet server, you can quickly remote control an application using the `-e` switch to execute a command and pipe its stdin/stdout via the network port.

Be careful with this though as it is a huge security risk if you are not careful.  The application you are remote controlling may be able to give a user more access and may ultimately be as bad as doing:

    $ nc -l -p 3333 -e /bin/sh

#### Interactively Control an Application
To remote control `gdb`, the Gnu Debugger:

On the server

    $ nc -l -p 3333 -e /usr/bin/gdb

On the client

    $ nc server.example.com 3333

or

    $ telnet server.example.com 3333


#### Using Expect to Control an Application
As above to remote control `gdb`, but this time it will be controlled via an `expect` script.  The example brings up the help text within `gdb` and then quits.

On the server

    $ nc -l -p 3333 -e /usr/bin/gdb

On the client create the following expect script as `control_remote_gdb.exp`

{% highlight tcl %}
#!/usr/bin/env expect
spawn telnet server.example.com 3333

expect "(gdb)"
send "help\r"

expect "(gdb)"
send "quit\r"

expect eof
{% endhighlight %}

Now run the expect script

    $ ./control_remote_gdb.exp


### Connecting an Emulated Serial Port to pppd
When emulating a Commodore 64 within Vice you can pipe the input/output of the emulated RS-232 port to a command.  This can be used to create an internet connection from the emulator by setting the exec process within Vice to '`|nc 127.0.0.1 3333`' and on the host machine run:

    # pppd 9600 :192.168.1.64 passive nodetach noauth local pty "nc -l -p 3333 127.0.0.1"

`pppd` here uses a pseudo terminal to communicate with, which is using netcat to create a link between it and the virtual RS-232 port of the emulator.

### Quick and Dirty File Transfer
For these examples, there are alternatives such as `scp`, `rsync`, etc.  However, when security is less of an issue and you have netcat to hand, this is a really easy solution.

#### Single File Transfer
To transfer a single file between the client and the server.

Receiver (Server)

    $ nc -l -p 3333  > someFile.tar

Sender (Client)

    $ cat someFile.tar | nc receiver.example.com 3333


#### Create and Transfer a Tar File on the Fly
To create a tar file from a directory and transfer it between the client and server.  The single `-` below tells tar to send to stdout.

Receiver (Server)

    $ nc -l -p 3333 | > someFile.tar.gz

Sender (Client)

    $ tar -czvf - someDir | nc receiver.example.com 3333

## Where now?
There are many places that `nc` can make things easier.  You probably won't need it everyday, but keep it in the back of your mind.  One day something may come up where you find that `nc` is the perfect answer.

