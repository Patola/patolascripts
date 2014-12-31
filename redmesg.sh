#!/bin/zsh - 
#===============================================================================
#
#          FILE: redmesg.sh
# 
#         USAGE: ./redmesg.sh 
# 
#   DESCRIPTION: http://www.commandlinefu.com/commands/view/11074/dmesg-with-colored-human-readable-dates
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio Sampaio (Patola), csampaio@br.ibm.com
#  ORGANIZATION: IBM
#       CREATED: 08/02/2012 06:46:06 AM BRT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
dmesg -T|sed -e 's|\(^.*'`date +%Y`']\)\(.*\)|\x1b[0;34m\1\x1b[0m - \2|g'

