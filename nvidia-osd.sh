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


while :
do
  #/usr/bin/nvidia-smi | head -9 | tail -1 | read x1 fan temperature pstate power x2 totalpower x3 memusage x4 memtotal x5 gpupercent uncorrupted x6
  #/usr/bin/nvidia-smi | awk '(FNR==9) {print $2,$3,$4,$5,$7,$9,$11,$13,$14 }' | read fan temperature pstate power totalpower memusage memtotal gpupercent uncorrupted
  /usr/bin/nvidia-smi --query-gpu=fan.speed,temperature.gpu,pstate,power.draw,memory.used,memory.total,utilization.gpu --format=csv,noheader,nounits | read fan temperature pstate power memusage memtotal gpupercent
  /usr/bin/osd_cat -p top -A right -l 6 -c yellow -S black -a=10 -s 1 <<EOF
FAN: ${fan%%,*}%
TEMP: ${temperature%%,*}°C
PSTATE: ${pstate%%,*}
P.USAGE: ${power%%,*} W
MEM: ${memusage%%,*} MiB
GPU PERC.: ${gpupercent%%,*}%
EOF
done
