#!/bin/zsh
#===============================================================================
#
#          FILE: virgula.sh
# 
#         USAGE: ./virgula.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio Sampaio (Patola), csampaio@br.ibm.com
#  ORGANIZATION: IBM
#       CREATED: 07/31/2012 08:50:21 AM BRT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

ALL=""
tty -s || while read line
do
  ALL="${ALL}\n${line}"
done
ALL="${ALL} $@"

echo $(echo "$ALL")

