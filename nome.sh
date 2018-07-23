#!/bin/zsh - 
#===============================================================================
#
#          FILE: nome.sh
# 
#         USAGE: ./nome.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 22/07/2018 22:53:52 -03
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
typef=()

[[ $# < 1 ]] && {
  echo "Needs at least one argument (filename)"
  exit 1
}

[[ "$1" == "-f" ]] && {
  typef=(-type f)
  shift
}

if [[ "$1" == "-d" && "$2" != "" ]]
then
  dir="$2"
  shift 2
else
  dir="."
fi

/usr/bin/find "$dir" $typef -iname "*${1}*"
