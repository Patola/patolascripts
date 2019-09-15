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

exec > /tmp/x52-patola.log 2>&1
x52output bri 0 127
x52output bri 1 127
x52output text 0 "$(date '+  %Y-%m-%d %H:%M')"
x52output text 1 "  Ready f/ Action "
x52output text 2 "  [X] Cmdr.Patola "

for i in 6 8 18
do
x52output led ${i} 1
done


X52ERR=0
set -o nomonitor
while [[ $X52ERR == 0 ]]; do
  sleep 60
  x52output time 1 $(date '+%H') $(date '+%M')
  x52output date $(date '+%Y') $(date '+%m') $(date '+%d')
  X52ERR=$?
  x=$((RANDOM%3))
  y=$((RANDOM%3))
  case $y in
    0)
      x52output led 7 $(((x+1)/2))
      x52output led 6 $(((x+1)%2))
    ;;
    1)
      x52output led 9 $(((x+1)/2))
      x52output led 8 $(((x+1)%2))
    ;;
    2)
      x52output led 19 $(((x+1)/2))
      x52output led 18 $(((x+1)%2))
    ;;
  esac
  x52output text 1 "  $(LC_NUMERIC=C uptime | cut -d: -f5 | cut -c2- | tr ' ' '_') "
  textres="  $(ps -ef | grep 'jogos\\steam\\steamapps\\common' | grep -v grep | head -1 | sed 's/.*common\\\(.*\)\\.*/\1                /' | cut -c1-16)"
  [[ "$textres" != "  " ]] && x52output text 2 "$textres"

done &


