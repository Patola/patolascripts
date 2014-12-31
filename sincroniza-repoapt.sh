#!/bin/zsh - 
#===============================================================================
#
#          FILE: sincroniza-repoapt.sh
# 
#         USAGE: ./sincroniza-repoapt.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio Sampaio (Patola), csampaio@br.ibm.com
#  ORGANIZATION: IBM
#       CREATED: 05-08-2012 22:40:18 BRT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

cd /home/patola
scp -rp apt pokgsa.ibm.com:/home/p/a/patola/web
