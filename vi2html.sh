#!/bin/bash - 
#===============================================================================
#
#          FILE: vi2html.sh
# 
#         USAGE: ./vi2html.sh file
# 
#   DESCRIPTION: turns a file into a html syntax-colored file.
# 
#       OPTIONS: file - the file that would appear colored in vim. 
#  REQUIREMENTS: vim with syntax coloring
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio Sampaio (Patola), csampaio@br.ibm.com
#  ORGANIZATION: IBM
#       CREATED: 07-08-2012 18:51:05 BRT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
file="$1";vim ${file} -e -s -c 'set background=light' -c 'runtime! syntax/syntax.vim' -c 'runtime! syntax/2html.vim' -c "w ${file}.html" -c 'q!' -c 'q!' > /dev/null

