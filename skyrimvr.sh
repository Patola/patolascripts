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
#echo "1='$1' 2='$2' 3='$3' 4='$4' 5='$5' 6='$6' 7='$7' 8='$8' 9='$9'' @='$@'" >> /tmp/aaa.txt
/usr/bin/gamemoderun "$1" "$2" /jogos/steam/steamapps/common/SkyrimVR/sksevr_loader.exe
#/usr/bin/gamemoderun "$1" "$2" "$3" "$4" "$5" "$6" "$7" /jogos/steam/steamapps/common/SkyrimVR/sksevr_loader.exe
#( sleep 30 ; '/jogos/steam/steamapps/common/Proton - Experimental'/dist/bin/wine64 /jogos/steam/steamapps/common/SkyrimVR/sksevr_loader.exe ) &
#"$@"

