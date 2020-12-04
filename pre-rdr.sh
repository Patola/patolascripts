#!/bin/zsh - 
#===============================================================================
#
#          FILE: pre-rdr.sh
# 
#         USAGE: ./pre-rdr.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 11/21/2020 04:13:40 PM CET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
/bin/sleep 5
PID=$(/usr/bih/pgrep RDR2.exe); kill -s SIGSTOP $PID; kill -s SIGCONT $PID
