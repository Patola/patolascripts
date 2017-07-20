#!/bin/zsh - 
#===============================================================================
#
#          FILE: waitfor.sh
# 
#         USAGE: ./waitfor.sh <PID>, or
#                ./waitfor.sh <process name>
# 
#   DESCRIPTION: waits for one process to finish without using loops. 
# 
#       OPTIONS: None so far
#  REQUIREMENTS: inotifywait installed
#    EXIT CODES: 4 no PID, 5 more than one named process, 3 more than one process,
#                54 for timeout command not present, 124 for timeout elapsed
#          BUGS: None so far
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 07/18/2017 05:43:26 PM -03
#      REVISION:  01
#===============================================================================

set -o nounset                              # Treat unset variables as an error
PROG=$0

usage() {
  echo " Usage:" >&2
  echo "$(basename $PROG) [-t time] <pid of process>, or" >&2
  echo "$(basename $PROG) [-t time] <name of process>, or" >&2
  echo "$(basename $PROG) --help" >&2
  echo -e "\nWaits for one process to finish by select() instead of polling (i.e., not looping until it exits)." >&2
  echo "If timeout <time> is reached, it stops waiting and exits with no error code." >&2
}

zparseopts -D -E -A Args -- t: -help

(( ${+Args[--help]} )) && {
  usage
  exit 0
}

TIMECMD=""
(( ${+Args[-t]} )) && {
  if [[ ${Args[-t]} =~ ^[0-9][0-9]*$ ]]
  then
    TIMECMD="/usr/bin/timeout"
    TIMEDURATION="${Args[-t]}"
  else
    echo "Time parameter must be numeric (seconds), '${Args[-t]}' is not." >&2
    usage
    exit 2
  fi
}

[[ $# -eq 1 ]] || {
  usage
  exit 3
}

[[ -x /usr/bin/timeout ]] || {
  echo "This script requires the timeout command present on the system to work." >&2
  echo "Please install coreutils." >&2
  exit 54
}

if [[ $1 =~ ^[0-9][0-9]*$ ]] # formed only of digits
then
  PID=$1
  [[ -d /proc/$PID ]] || {
    echo "Process with PID $PID does not exist." >&2
    usage
    exit 4
  }
else
  PID=$(/usr/bin/pgrep "$1")
  [[ $(echo $PID | /usr/bin/wc -w) -gt 1 ]] && {
    echo "There are $(echo $PID | wc -w ) processes with '$1' on it: $(echo $PID | sed ':a;N;$!ba;s/\n/, /g')." >&2
    echo "The command requires only one process." >&2
    usage
    exit 5
  }
fi

#/usr/bin/inotifywait -e close /proc/$PID/cgroup > /dev/null 2>&1
$TIMECMD $TIMEDURATION /usr/bin/tail -f /dev/null --pid=$PID
exit $?
