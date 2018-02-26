#!/bin/zsh -
#===============================================================================
#
#          FILE: log_time_end.sh
#
#         USAGE: log_time_end.sh <name of executable>
#
#   DESCRIPTION: logs time spent by games/apps. Records all info in a text-file
#                (~/logs/executable.ltime) in natural language.
#       OPTIONS: No option.
#     ARGUMENTS: The executable and its parameters, like sleep 30
#  REQUIREMENTS: zsh. This script was designed to despise the primitive bash.
#          BUGS: Bzz.
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 25/02/2018 22:56:47 -03
#       VERSION: 0.9b
#      REVISION: By a bunch of monkeys (NOT apes).
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

convertsecs() {
  [[ $1 != [0-9]* ]] && exit 3
  ((h=${1}/3600))
  ((m=(${1}%3600)/60))
  ((s=${1}%60))
  printf "%02d:%02d:%02d\n" $h $m $s
}

function log_time_end() {
  [[ "$@" == "" ]] && { echo "Argumento vazio." ; exit 4 }
  SECONDS=0

  executavel="$1"
  which "$executavel" >&- && executavel=="${executavel}"

  arquivolog="$(echo "$executavel" | tr ' ' '_' | tr -cd '_a-zA-Z0-9-').ltime"
  [[ ! -d ~/logs ]] && { echo "Erro, não existe diretório de log"; exit 7 }
  [[ ! -f ~/logs/"${arquivolog}" ]] && { echo "Erro, não existe arquivo de log"; exit 7 }

  datainicio="$(tail -1 ~/logs/${arquivolog} | cut -d' ' -f12-13)"
  datafim="$(date '+%Y-%m-%d %H:%M:%S')"
  let tempogasto=$(date --date="${datafim}" '+%s')-$(date --date="${datainicio}" '+%s')

  if [[ -f ~/logs/"${arquivolog}" ]]
  then
    tempoanterior="$(tail -1 ~/logs/${arquivolog} | cut -d' ' -f6)"
    let tempototal=tempoanterior+tempogasto
  else
    let tempototal=tempogasto
  fi

  echo "$tempogasto seconds this time ($(convertsecs $tempogasto)), $tempototal seconds total time ($(convertsecs $tempototal)). [started $datainicio and ended $datafim]" | tee -a ~/logs/"${arquivolog}"
  return 0
}

log_time_end "$@"
