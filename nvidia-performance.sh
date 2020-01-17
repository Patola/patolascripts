#!/bin/zsh - 
#===============================================================================
#
#          FILE: nvidia-performance.sh
# 
#         USAGE: ./nvidia-performance.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 29/12/2019 23:19:34 -03
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
/usr/bin/nvidia-settings -a '[gpu:0]/GPUPowerMizerMode=1'

