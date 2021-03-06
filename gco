#!/bin/zsh

[[ -d /media/patola/Reprap\ SD/gcode ]] || {
  echo "Reprap SD not mounted. Please mount it before running this script.\n"
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

  /bin/sed -n '/^\;CURA_PROFILE_STRING/!p' "$file" | /usr/bin/awk 'BEGIN {x=0} ($0 ~ /^\;Sliced at:/) {x=1} (x==1) {print $0}' | /usr/bin/awk '{print (FNR<30 && $0 ~ /^G0 F([0-9.]+) X([0-9.]+) Y([0-9.]+) Z([0-9.]+)/)?"G0 F200 " $3 " " $4 " " $5:$0}' > /media/patola/Reprap\ SD/gcode/"$(/usr/bin/basename "$file")" && echo "Copied '$file' to '/media/patola/Reprap SD/gcode/$(/usr/bin/basename "$file")'."
done
