#!/bin/zsh - 
#===============================================================================
#
#          FILE: essh-config-creator.sh
# 
#         USAGE: ./essh-config-creator.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio Sampaio (Patola), csampaio@br.ibm.com
#  ORGANIZATION: IBM
#       CREATED: 05-08-2012 00:49:49 BRT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
RESP="$(dialog --stdout --backtitle 'essh configuration creator' --title 'Create new essh configuration' \
  --form '\nPlease fill in the fields (* means required)' 30 80 16 \
  'Configuration Name *' 1 1 "" 1 40 40 39 \
  "Group" 2 1 "IBM" 2 40 40 39 \
  'Login' 3 1 "$(id -un)" 3 40 40 39 \
  'Logging' 4 1 "yes" 4 40 4 3 \
  'ssh quiet mode (avoids banner)' 5 1 "yes" 5 40 4 3 \
  'Minimum size for logfile' 6 1 '300' 6 40 10 9 \
  'ssh port' 7 1 '22' 7 40 6 5 \
  'tsocks script (auto, scriptname or no)' 8 1 'auto' 8 40 40 39 \
  'Hostmasks (wildcards) e.g. vnx* sax*' 9 1 '' 9 40 40 400 \
  'Hostmasks (regexp) e.g. ^[vs]nx.*|^sax' 10 1 '' 10 40 40 400 \
  'Bridged? ("no" or servername)' 11 1 'no' 11 40 40 39 \
  'Special hosts file (empty if none)' 12 1 '' 12 40 40 39 \
  'Extra parameters for ssh' 13 1 '-X' 13 40 40 39 \
  'Pre-setup script' 14 1 'export LC_ALL=pt_BR.ISO-8859-15 LANG=pt_BR.ISO-8859-15 LC_COLLATE=pt_BR.ISO-8859-15' 14 40 40 400 \
  'Interfaces (if:IP) - e.g. eth0:9.18.' 15 1 '' 15 40 40 39 \
  'Change tab/terminal title?' 16 1 'yes' 16 40 4 3 ; echo $?)"

if [[ "$RESP" == 1 ]]
then
  returncode=1
else
  returncode=0
  echo "$RESP" | { read name ; read group ; read login ; read logging ; read quiet ; read minrmlog ; read port ; read tsocks; read hostmasks ; read hostmasksre ; read bridged ; read hostsfile ; read extrapar ; read presetup ; read ifverify ; read changetabname ; read returncode }
fi

if [[ $returncode -eq 0 ]]
then 
  echo "NAME=$name
GROUP=$group
USER=$login
LOG=$logging
QUIET=$quiet
MINRMLOG=$minrmlog
PORT=$port
TSOCKS=$tsocks
HOSTMASKS=$hostmasks
HOSTMASKSRE=$hostmasksre
BRIDGED=$bridged
HOSTSFILE=$hostsfile
EXTRAPAR=$extrapar
PRESETUP=$presetup
IFVERIFY=$ifverify
CHANGETABNAME=$changetabname" > ~/.essh/conf_${name}
  echo Configuration saved on ~/.essh/conf_${name}.
else
  echo Operation cancelled.
fi
