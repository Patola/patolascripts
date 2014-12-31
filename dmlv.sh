#!/bin/sh

dms="$(/usr/bin/awk '$3 ~ /^dm-/ {printf "%s,%s %s\n",$1,$2,$3}' /proc/diskstats)"
#lvs="$(/bin/ls --time-style=long-iso -l /dev/mapper/ | egrep -v '^[tdc]' | awk '($9 !~ /-/) {$9="N/A-"$9} {printf "%s%s %s\n",$5,$6,$9}')"
lvs="$(find /dev/mapper -type l | while read lv; do b="$(readlink "$lv")"; echo $( ( echo ibase=16; stat --printf="%t\n" "/dev/mapper/$b" | tr 'a-z' 'A-Z') | bc -l ),$( ( echo ibase=16; stat --printf="%T\n" "/dev/mapper/$b" | tr 'a-z' 'A-Z') | bc -l ) "$lv"; done)"

( echo "MAJOR MINOR VG LV/DEV DM"
echo "$dms" | while read a b
do
  echo "$lvs" | tr '-' ' ' | awk '($1=="'"$a"'") {printf "%s %s\n",$0,"'"$b"'"}'
done | sed 's/^\([0-9][0-9]*\),\([0-9][0-9]*\)/\1 \2/' ) | /usr/bin/column -t

