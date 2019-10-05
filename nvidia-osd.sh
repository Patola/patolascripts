#!/bin/zsh - 
#===============================================================================
#
#          FILE: nvidia-osd.sh
# 
#         USAGE: ./nvidia-osd.sh 
# 
#   DESCRIPTION: Shows in OSD some nvidia stats
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 05/10/2019 14:05:51 -03
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

trap "pkill osdsh; exit 0" TRAP INT ABRT KILL QUIT HUP TERM

/usr/bin/osdsh -p 0 -a 2 -c yellow -o 1 -d 5
while :
do
  /usr/bin/osdctl -s "$(/usr/bin/nvidia-smi --query-gpu=fan.speed,temperature.gpu,pstate,power.draw,memory.used,memory.total,utilization.gpu --format=csv,noheader,nounits | read fan temp pstate power mem memtotal gpu ; echo "FAN ${fan%%,} TEMP ${temp%%,}C PST ${pstate%%,} POW ${power%%,}W MEM ${mem%%,}MiB GPU ${gpu%%,}%")"
  sleep 5
done

pkill osdsh # just in case
