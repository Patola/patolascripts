#!/bin/zsh - 
#===============================================================================
#
#          FILE: start-session.sh
# 
#         USAGE: ./start-session.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 06/07/2018 19:39:13 -03
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
/usr/bin/pacmd set-default-sink alsa_output.pci-0000_22_00.1.hdmi-stereo-extra1

# FULL SPEED AHEAD!
for a in {0..15}
do
  sudo cpufreq-set -c $a -g performance
done

#NVIDIA: Force full composition pipeline
/usr/bin/nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
/usr/bin/nvidia-settings -a '[gpu:0]/GPUPowerMizerMode=1'
/home/patola/bin/nvidia-performance.sh

#/usr/bin/pacmd set-default-sink alsa_output.usb-045e_Microsoft_LifeChat_LX-3000-00.iec958-stereo
/usr/bin/xgamma -gamma 1.2
~/bin/teclado.sh
/usr/bin/xset s 3600
