#!/bin/zsh - 
#===============================================================================
#
#          FILE: resteam.sh
# 
#         USAGE: ./resteam.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 11/29/2020 06:54:25 PM CET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
while :
do
  sleep 30
  ps -ef | grep -v grep | grep -v dumps/assert | grep -v resteam.sh | grep steam > /dev/null 2>&1 || launch /usr/games/steam
  z="$(ps -ef | grep -v grep | grep steam | grep -v steamwebhelper | grep -v fossilize_replay | grep -v dumps/assert | sort -n -k 7 | tail -1 | awk '{print $7}')"; [[ "$z" =~ [0-9][0-9]:[0-9][0-9]:[0-9][0-9] && "$z" > "00:30:00" ]] && break
done

exit 0
