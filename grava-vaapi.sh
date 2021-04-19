#!/bin/zsh - 
#===============================================================================
#
#          FILE: grava-vaapi.sh
# 
#         USAGE: ./grava-vaapi.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 03/07/2021 12:38:52 AM CET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
/usr/bin/ffmpeg -vaapi_device /dev/dri/renderD128 -f x11grab -video_size 2560x1080 -framerate 60 -i :0 -c:v h264_amf -rc cqp -qp_p 10 -qp_i 10 -vsync 2 -threads 11 /jogos2/videos/output-vaapi.mp4

