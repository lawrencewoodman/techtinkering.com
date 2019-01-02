!* commandChar @
Ornament is a Tcl template module that allows you to define, parse and compile a template to produce a script which can then be run using a safe interpreter.  The idea came from the [Templates and subst](https://wiki.tcl.tk/18455) page of the [Tclers Wiki](https://wiki.tcl.tk).

## Module Commands
Ornament has two commands:

<dl>
  <dt><code>compile</code></dt>
  <dd>Takes a template and outputs a script to be evaluated with <code>run</code></dd>

  <dt><code>run</code></dt>
  <dd>Takes a script created with <code>compile</code> and evaluates it using a safe interpreter to create its final output.</dd>
</dl>

## Usage

You control _ornament_ using a `commandChar` in the first column of a line, this defaults to `!`.  If you want to change the `commandChar` you can do so using the `commandChar` followed by `*`.

```` tcl
!# This is a command
!* commandChar %
%# commandChar is now %, so we have to use %# as a comment
%* commandChar !
!# Now we are back to where we started
````
<br />

The following Tcl script demonstrates how to use _ornament_.

```` tcl
package require ornament
namespace import ornament::*

# This is the template
set tpl {
!# You can configure ornament the defaults are:
!#    commandChar     !
!#    commandSubst    false
!#    variableSubst   false
!#    backslashSubst  false
!* commandSubst true variableSubst true backslashSubst true
!#
This is some normal text
!# This is a comment and is ignored by `compile`
!# The following line will be executed as it begins with a `!` followed by a space
! for {set i 0} {$i < 5} {incr i} {
    Number: $i
! }

!# You can also use `!!` followed by a space instead of a `!`
!! set flow 152
flow: $flow

!# You can use `\` at the end of a line beginning with `!` or `!!` to
!# continue it
! set nums [list 1 2 \
                 3 4]
nums: $nums

!# Alternatively you can continue a line using `!\` at the start
!\ set letters [list a b
!                    c d]
letters: $letters

 ! Because the ! wasn't in the first column of the line, this line isn't executed
!# Below some variables are used that have been passed to the template:
Name: $name
Age: $age
!# Below a command is called that has been passed to the template:
I want to say: [greet $name]

!# You can change the command character to anyone of {! % @ ~}
!* commandChar %
% set nextAge [expr {$age + 2}]
nextAge: $nextAge
%* commandChar !

!# You can change whether variable substitution happens
!* variableSubst false
look at this: $nextAge
!* variableSubst true
and now: $nextAge

!# You can change whether command substitution happens
!* commandSubst false
look at this: [expr {5 + 6}]
!* commandSubst true
and now: [expr {5 + 6}]

!# You can change whether backslash substitution happens
!* backslashSubst false
look at this:\n
!* backslashSubst true
and now:\n
}


# int is the safe interpreter that is running the script
proc CmdGreet {greeting int name} {
  return "$greeting $name"
}

# You can pass commands to the template
set cmds [dict create greet [list CmdGreet "hello"]]

# You can pass variables to the template
set vars [dict create name Brodie age 37]

set script [compile $tpl]
puts [run $script $cmds $vars]
````
<br />

The script above gives the following output.

    This is some normal text
        Number: 0
        Number: 1
        Number: 2
        Number: 3
        Number: 4

    flow: 152

    nums: 1 2 3 4

    letters: a b c d

     ! Because the ! wasn't in the first column of the line, this line isn't executed
    Name: Brodie
    Age: 37
    I want to say: hello Brodie

    nextAge: 39

    look at this: $nextAge
    and now: 39

    look at this: [expr {5 + 6}]
    and now: 11

    look at this:\n
    and now:



## Ornament on GitHub
There is a [repo](https://github.com/lawrencewoodman/ornament_tcl) on GitHub, from which you can download Ornament and where you can contribute to it.  There is also an [issues tracker](https://github.com/lawrencewoodman/ornament_tcl/issues) where you can report bugs.


## Licence
Copyright (C) 2018 Lawrence Woodman <lwoodman@vlifesystems.com>

This software is licensed under an MIT Licence.  Please see the file, [LICENCE.md](https://github.com/lawrencewoodman/ornament_tcl/blob/master/LICENCE.md), for details.
