#!/bin/zsh - 
#===============================================================================
#
#          FILE: save-dreadout.sh
# 
#         USAGE: ./save-dreadout.sh 
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
#SAVESDIR="/jogos/steam/steamapps/common/DreadOut/cloud/96679891/20170627084344"
SAVESDIR="/jogos/steam/steamapps/compatdata/269790/pfx/drive_c/users/steamuser/AppData/LocalLow/Digital Happiness/dreadout/96679891/20170627084344"
COPYTO="/jogos/backup/dreadout/saves"
lastsave="$(ls -1tr "$SAVESDIR"/save.[0-9]* | tail -1)"
[[ ( "$lastsave" -nt "$(ls -1trd "$COPYTO"/*/ | tail -1)/$(basename $lastsave)" ) && ( $(md5sum "$lastsave") != $(md5sum "$(ls -1trd "$COPYTO"/*/ | tail -1)/$(basename $lastsave)") ) ]] && { # we got something new, back it up
  data="$(date '+%Y%m%d%H%M')"
  mkdir -p "$COPYTO"/"$data"
  cp -p "$SAVESDIR"/* "$COPYTO"/"$data"
}

exec "$@"
