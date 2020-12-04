#!/bin/zsh - 
#===============================================================================
#
#          FILE: skyrimvr.sh
# 
#         USAGE: ./skyrimvr.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 21/06/2020 00:08:12 CEST
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error
/home/patola/bin/dejoysticka.sh
"$@"
/home/patola/bin/rejoysticka.sh
