#!/bin/zsh - 
#===============================================================================
#
#          FILE: waitfor.sh
# 
#         USAGE: ./waitfor.sh 
# 
#   DESCRIPTION: waits for one process to finish without using loops. 
# 
#       OPTIONS: None so far
#  REQUIREMENTS: inotifywait installed
#          BUGS: None so far
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 07/18/2017 05:43:26 PM -03
#      REVISION:  01
#===============================================================================

set -o nounset                              # Treat unset variables as an error

usage() {
  echo " Usage:" >&2
  echo "$0 <pid of process>, or" >&2
  echo "$0 <name of process>" >&2
  echo -e "\nWaits for one process to finish by select() instead of polling (i.e., not looping until it exits)." >&2
}

[[ $# -eq 1 ]] || {
  usage;
  exit 3
}

[[ -x /usr/bin/inotifywait ]] || {
  echo "This script requires inotifywait present on the system to work." >&2
  echo "Please install inotifywait." >&2
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

/usr/bin/inotifywait -e close /proc/$PID/cgroup > /dev/null 2>&1
exit $?
