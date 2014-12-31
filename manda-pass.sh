#!/bin/zsh - 
#===============================================================================
#
#          FILE: manda-pass.sh
# 
#         USAGE: ./manda-pass.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio Sampaio (Patola), csampaio@br.ibm.com
#  ORGANIZATION: IBM
#       CREATED: 10-11-2012 05:48:39 BRST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
printf "Enter your passphrase: \c"
read passphrase

empty -f -i in -o out "$@"
empty -v -w -i out -o in "Please enter passphrase:" "$passphrase"
RC=$?
while [[ $RC -lt 10 ]]
do
  empty -v -w -i out -o in "Please enter passphrase:" "$passphrase"
done

