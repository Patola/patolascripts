#!/bin/zsh - 
#===============================================================================
#
#          FILE: lafora.sh
# 
#         USAGE: ./lafora.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 31/08/2016 05:26:38 BRT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
launch python ~/bin/cam.py --address=10.0.0.54 --port=81 --mode=720P --bitrate=1024 --framerate=15

