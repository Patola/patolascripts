#!/bin/zsh - 
#===============================================================================
#
#          FILE: x52setup.sh
# 
#         USAGE: ./x52setup.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 14/09/2019 20:40:25 -03
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

exec >> /tmp/x52-patola.log 2>&1
pkill -f x52setup.sh

x52output bri 0 0
x52output bri 1 0
x52output text 0 "XX$(date '+  %Y-%m-%d %H:%M')"
x52output text 1 "  SAITEK X52 PRO  "
x52output text 2 "---- stopped -----"
x52output text 0 "$(date '+  %Y-%m-%d %H:%M')"
x52output text 1 "  SAITEK X52 PRO  "
x52output text 2 "---- stopped -----"
x52output text 0 "$(date '+  %Y-%m-%d %H:%M')"

for i in 6 8 18
do
x52output led ${i} 0
done


