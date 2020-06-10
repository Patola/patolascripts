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
PROCESS=""
MYPID=$$

findwinbypid() {
  findpid=$1

  declare -a known_windows=( $( ( xwininfo -root -children|sed -e 's/^ *//'|grep -E "^0x"|awk '{ print $1 }' ; wmctrl -l | awk '{print $1}' ) | sort | uniq ) )
  for id in ${known_windows}
  do
      pid=$(xprop -id $id _NET_WM_PID 2> /dev/null | awk '{print $3}')
      if [[ "$pid" != "" ]]; then
          if [[ "${pid}" == "${findpid}" ]]
          then
              echo "$id" 
          fi
      fi
  done
}


#set -o nounset                              # Treat unset variables as an error
[[ $# -eq 0 ]] && {
  echo "Usage: $0 <interval in seconds> [ <process to monitor> ]" >&2
  echo ""
  echo "- interval in seconds: at each n seconds, it will take a screenshot."
  echo ""
  echo "- process to monitor: a pid or a string. If it is a string, it will try"
  echo "  and get the window and pid based on that. If it is a number it will"
  echo "  consider it a pid. Once specified, it will continue while this"
  echo"   process pattern (name) exist."
  echo "  Once it exits, the script also exits. If not specified, the script will go on forever."
  echo ""
  echo "Note: pictures are saved in \"$SAVEDIR\"."
  exit 1
}

INTERVAL=$1

[[ $INTERVAL =~ "^[0-9][0-9]*$" ]] || {
  echo "\"$INTERVAL\" is not a numeric value. Please try again." >&2
  exit 3
}

if [[ "$2" != "" ]]
then
#  PROCESS="$(ps -eo pid,cmd | awk '($1!='$MYPID' && $2~/'"$(echo "$2" | sed 's#/#\\/#g')"'/) {print $1}' | tail -1)"
#  PROCESS=$(ps -eo pid,cmd | awk '($1!=MYPID)' MYPID=$MYPID | grep "$(echo "$2" | sed 's#/#\\/#g')" | awk '{print $1}' | tail -1)
#  PROCESS=$(pgrep -af "$2" > /tmp/nada.txt; pgrep -f "$2" | grep -v "^${MYPID}$" | tail -1)
  pgrep -f "$2" | grep -v "^${MYPID}$" | tail -1 | read PROCESS
  [[ $PROCESS == "" ]] && {
    echo "The process \"$2\" is not even running."
    echo "You have to start this script *after* having"
    echo "started the process. If needed, use something"
    echo "like \"sleep n; $0 n mygame\"."
    exit 5
  }
else
  PROCESS=$MYPID
  windowid=$(findwinbypid $PROCESS)
  [[ $windowid != "" ]] && windowname=$(xprop -notype -id $windowid WM_NAME | sed 's/[^"]*\"//;s/"$//')
fi

while [[ -d /proc/$PROCESS ]]
do
  if [[ $windowid != "" ]]
  then
    /usr/bin/maim -i $janela > ~/Pictures/screenshots/maim-screenshot-${windowname:-game}-$(date '+%Y%m%d%H%M%S').png
  else
    /usr/bin/flameshot full -p "$SAVEDIR"
  fi
  sleep $INTERVAL
done

echo "Hey! Process \"$PROCESS\" left sometime around $(date)."
