#!/bin/zsh - 
#===============================================================================
#
#          FILE: uia.sh
# 
#         USAGE: ./uia.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio Sampaio (Patola), csampaio@br.ibm.com
#  ORGANIZATION: IBM
#       CREATED: 24-10-2012 05:26:28 BRST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
for file in /var/log/*(.)
do
  if [[ "$file" == *.gz && ! "$file" == *.tar.gz ]]
  then
    gzip -d "$file"
    file="${file%.*}"
    egrep -v 'kernel:.* sd [0-9][0-9]*:[0-9][0-9]*:[0-9][0-9]*:[0-9][0-9]*: |usb|USB|removable disk|scsi.*Direct-Access' < "$file" > "${file}".newfile
    cat "${file}".newfile > "$file" && rm "${file}".newfile
    gzip -9 "${file}"
  else
    egrep -v 'kernel:.* sd [0-9][0-9]*:[0-9][0-9]*:[0-9][0-9]*:[0-9][0-9]*: |usb|USB|removable disk|scsi.*Direct-Access' < "$file" > "${file}".newfile
    cat "${file}".newfile > "$file" && rm "${file}".newfile
  fi
done

