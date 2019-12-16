#!/bin/zsh - 
#===============================================================================
#
#          FILE: save-galaxysquad.sh
# 
#         USAGE: ./save-galaxysquad.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 25/07/2019 03:34:55 -03
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

SAVEFILE="/home/patola/.config/unity3d/Oleg Kazakov/Galaxy Squad/saveData.txt"
COPYTO="/jogos/backup/galaxysquad/saves"
[[ ( "$SAVEFILE" -nt "$(ls -1trd "$COPYTO"/*/ | tail -1)/saveData.txt" ) && ( $(md5sum "$SAVEFILE") != $(md5sum "$(ls -1trd "$COPYTO"/*/ | tail -1)/saveData.txt") ) ]] && { # we got something new, back it up
  data="$(date '+%Y%m%d%H%M')"
  mkdir -p "$COPYTO"/"$data
  cp -p "$SAVEFILE" "$COPYTO"/"$data"/
}

exec "$@"
