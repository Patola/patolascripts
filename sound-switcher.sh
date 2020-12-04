#!/bin/zsh - 
#===============================================================================
#
#          FILE: sound-switcher.sh
# 
#         USAGE: ./sound-switcher.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 09/18/2020 02:36:54 PM CEST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
cd /dados/git/indicator-sound-switcher/build && PYTHONPATH=/usr/lib/python3.8/site-packages:.:/dados/git/indicator-sound-switcher/lib/indicator_sound_switcher:/dados/git/indicator-sound-switcher/build/lib:/dados/git/indicator-sound-switcher/build/scripts-3.8 /usr/local/bin/launch ./scripts-3.8/indicator-sound-switcher

