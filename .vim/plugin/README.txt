VIM xdebug for PHP

Created by
----------
Seung Woo Shin
 
Slightly modified by Khalid Baheyeldin (http://2bits.com)

Description
-----------
This python script provide debugger interface to DBGp protocol.
( but, only tested on Xdebug2.0 - http://www.xdebug.org/ )

Requirements
------------
- DBGp protocol enabled debugging module. such as xdebug.
  ( I don't know there are free DBGp debugger except xdebug)

- vim 6.3 or higher (tested on vim 6.3, and 7.0)

- python 2.3+ interface , +sign feature
  (< python 2.2 don't have socket timeout.)

- The vim scripts (debugger.vim / debugger.py)

Installation
------------
Copy all files in ~/.vim/plugin directory. 

Usage
-----
1. setup xdebug 2.0 correctly. or other DBGp enabled server.
   ( with proper remote debug option )

2. press <F5> and browse php file within 5 seconds. :-)
    If you did setup correctly, server will make connection to vim.
    [ you can change port by editing last line of debugger.vim ]

    All the windows currently opened will be closed and debugger
    interface will be shown.

3. in debuggin mode
   <F1>  : resizing windows
   <F2>  : step into
   <F3>  : step over
   <F4>  : step out

   <F6>  : stop debugging

   <F11> : shows all variables
   <F12> : shows variable on current cursor

   ,e    : evalute expression and display result. cursor is automatically move to watch
           window. type line and just press enter.

   Command line command
   :Bp   : toggle breakpoint on current line
   :Up   : goto upper level of stack
   :Dn   : goto lower level of stack

4. press <F6> to stop debugging.
   then, debugger windows will be closed and windows will be restored.
   (holy :mksession feature )

5. Notes
   - You will see python's exception message. almost of them occurred when connection
     is closed. xdebug dosen't send message for last file/line information.
     just press <F6> to restore sesson. sometimes are xdebug's bug.
   - To use with a lot of people with same time, it may needs DBGp proxy. you may
     download MIT licensed(?) version of it from activestate's komodo's evalution copy.
     and, you have to change this script a little.
   - It doesn't all features of DBGp. very essential part of it.

*** There will be no future release plan of this script.***

Currently Seung is working on a PHP interface on vim, and will use my php version of this
debugger.

Tips
----
Turning off syntax highlighting will increase speed considerably, but it is not pretty.
Use the command:

:syn off
 
