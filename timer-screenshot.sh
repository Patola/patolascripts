#!/bin/zsh - 
#===============================================================================
#
#          FILE: timer-screenshot.sh
# 
#         USAGE: ./timer-screenshot.sh 
# 
#   DESCRIPTION:  takes a screenshot every x seconds for games.
# 
#       OPTIONS: first argument: interval, second argument (optional): process
#  REQUIREMENTS: flameshot, although the game can be made to work with scrot/maim
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 31/05/2020 11:47:58 CEST
#      REVISION: 0.0000000000000000000000000000000000000000000000000000000000001
#===============================================================================

SAVEDIR=~/Pictures/screenshots
mkdir -p "$SAVEDIR" > /dev/null 2>&1
PROCESS=$0

set -o nounset                              # Treat unset variables as an error
[[ $# -eq 0 ]] && {
  echo "Usage: $0 <interval in seconds> [ <process to monitor> ]" >&2
  echo ""
  echo "- interval in seconds: at each n seconds, it will take a screenshot."
  echo "- if specified, it will continue while this process pattern (name) exist."
  echo "  Once it exits, the script also exits. If not specified, the script will"
  echo "  go on forever."
  echo ""
  echo "Note: pictures are saved in \'$SAVEDIR\"."
}

INTERVAL=$1

[[ $INTERVAL =~ "^[0-9][0-9]*$" ]] || {
  echo "\"$INTERVAL\" is not a numeric value. Please try again." >&2
  exit 3
}

[[ "$2" != "" ]] && PROCESS="$2"

pgrep -f "$PROCESS" > /dev/null 2>&1 || {
  echo "The process \"$0\" is not even running."
  echo "You have to start this screep *after* having"
  echo "started the process. If needed, use something"
  echo "like \"sleep n; $0 n mygame\"."
  exit 5
}

while pgrep -f "$PROCESS" > /dev/null 2>&1
do
  /usr/bin/flameshot full -p "$SAVEDIR"
  sleep $INTERVAL
done

echo "Hey! Process \"$PROCESS\" left sometime around $(date)."
