#!/bin/zsh
setopt nomonitor
( sleep 10 ; echo "$@" | osd_cat -o 300 -i 400 -s 8 -c red -d 10 -f "-adobe-helvetica-bold-r-normal-*-*-960-*-*-p-*-*-*" -d 10 ) &
