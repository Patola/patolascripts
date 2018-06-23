#!/bin/zsh
/usr/bin/pgrep 'yakuake|tilda|guake|terminator' && yaname "[   $(basename $PWD | tr a-z A-Z)   ]"
#/usr/bin/pgrep -f "python2 -m guake" > /dev/null 2>&1 && ganame "  $(basename $PWD | tr a-z A-Z)  "
