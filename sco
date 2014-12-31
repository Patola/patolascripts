#!/bin/zsh
#name="Reprap SD"
name='3DPRINT'

[[ -d /media/patola/"${name}"/gcode ]] || {
  echo "Reprap SD named "$name" not mounted. Please mount it before running this script.\n"
  exit 3
}


for first in "$@"
do

  if [[ -f "${first}" ]]
  then
    file="$first"
  elif [[ -f "${first}.gco" ]]
  then
    file="${first}.gco"
  elif [[ -f "/tmp/${first}.gco" ]]
  then
    file="/tmp/${first}.gco"
  elif [[ -f "/tmp/${first}" ]]
  then
    file="/tmp/${first}"
  else
    echo "Can't find file '$first'. Please check.\n"
    exit 2
  fi

  /usr/bin/awk 'BEGIN {o=0} (o==1) {print $0} (o==0) {if (FNR<300 && $0 ~ /^G0 X[0-9.]+ Y[0-9.]+ F4800/) { print "G0 " $2 " " $3 " F1000" ; o=1} else { print $0 } }' < "$file" > /media/patola/"${name}"/gcode/"$(/usr/bin/basename "$file")" && echo "Copied '$file' to '/media/patola/${name}/gcode/$(/usr/bin/basename "$file")'."
done
