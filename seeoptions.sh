#!/bin/zsh - 
#===============================================================================
#
#          FILE: seeoptions.sh
# 
#         USAGE: ./seeoptions.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio Sampaio (Patola), csampaio@br.ibm.com
#  ORGANIZATION: IBM
#       CREATED: 18-08-2012 04:27:51 BRT
#      REVISION:  ---
#===============================================================================

printf '%20s := %s\n' "${(@kv)options[(R)on]}" "${(@kv)options[(R)off]}"

