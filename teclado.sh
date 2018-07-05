#!/bin/zsh - 
#===============================================================================
#
#          FILE: teclado.sh
# 
#         USAGE: ./teclado.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 18/12/2017 13:02:06 -02
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
/usr/bin/setxkbmap -model pc105 -option lv3:ralt_switch_multikey 'us(altgr-intl)'

