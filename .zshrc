autoload -U compinit
compinit
export HISTFILE=~/.zsh_history SAVEHIST=10000 HISTSIZE=10000
setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY
setopt AUTO_LIST
setopt AUTO_CD
setopt RCS
setopt GLOBAL_RCS
setopt NONOMATCH
setopt RM_STAR_SILENT
setopt EXTENDEDGLOB
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt LIST_AMBIGUOUS
#export PS1='[${LOGNAME}@${HOSTNAME} ${PWD##/*/}]%# '
setopt APPEND_HISTORY
setopt AUTO_MENU
# OBS.: 38;5;color are 256 color codes
export ESC=$'\e'
cores=( "0;32" "0;36" "0;31" "0;35" "0;37" "1;34" "1;32" "1;36" "1;31" "1;35" "1;33" "1;37" )
hostnum=$(( $( hostname | sum | awk '{print $1}') + 31337 ))
cor1ind=$(( hostnum % 12 ))
cor2ind=$(( ((hostnum-cor1ind)/12)%12 ))
cor3ind=$(( ((((hostnum-cor1ind)/12)-cor2ind)/12)%12 ))
cor4ind=$(( ((((((hostnum-cor1ind)/12)-cor2ind)/12)-cor3ind)/12)%12 ))
c1=$cores[$cor1ind]
c2=$cores[$cor2ind]
c3=$cores[$cor3ind]
c4=$cores[$cor4ind]
#export ESC=''
#PROMPT="%{${ESC}[38;5;126m[${ESC}[38;5;13m%T${ESC}[38;5;126m] ${ESC}[38;5;34m[${ESC}[38;5;10m%h${ESC}[38;5;34m] ${ESC}[31m%}[%{${ESC}[36m%}%n%{${ESC}[39m%}@%{${ESC}[32m%}%m %{${ESC}[93m%}%C%{${ESC}[31m%}]%{${ESC}[39m%}%B%#%b "
#PROMPT="%{${ESC}[38;5;126m%}[%{${ESC}[38;5;13m%}%T%{${ESC}[38;5;126m%}] %{${ESC}[38;5;34m%}[%{${ESC}[38;5;10m%}%h%{${ESC}[38;5;34m%}] %{${ESC}[31m%}[%{${ESC}[36m%}%n%{${ESC}[39m%}@%{${ESC}[32m%}%m %{${ESC}[93m%}%C%{${ESC}[31m%}]%{${ESC}[39m%}%B%#%b "
PROMPT="%{${ESC}[38;5;126m%}[%{${ESC}[38;5;13m%}%T%{${ESC}[38;5;126m%}] %{${ESC}[38;5;34m%}[%{${ESC}[38;5;10m%}%h%{${ESC}[38;5;34m%}] %{${ESC}[${c1}m%}[%{${ESC}[${c2}m%}%n%{${ESC}[${c3}m%}@%{${ESC}[${c4}m%}%m %{${ESC}[${c3}m%}%C%{${ESC}[${c1}m%}]%{${ESC}[${c3}m%}%B%#%b "
unset ESC
#export RPROMPT='%{[36m%}%S%/%s%{[39m%} ' ! Bah! Nao preciso disso.
alias ls='ls --color=auto'
#case $(tty) in
#  /dev/pts/* ) export PROMPT="$PROMPT"'%{]0;MGT: %/%}'
#  ;;
#esac

. ~/.alias

#export CVSROOT=:pserver:patola@localhost.localdomain:/usr/local/cvs
#export CVSROOT=:pserver:patola@localhost.localdomain:/usr/local/cvs
#export CVS_RSH=ssh

#export PATH=$PATH:/usr/java/j2sdk1.4.1_01/bin:~/bin
export PATH="$PATH":~/bin # my own binaries
export PATH="$PATH":~/.gem/ruby/2.3.0/bin # gem (ruby) packages
export PATH="$PATH":~/.local/bin # pip (python) packages
export GOPATH=~/go
export GOBIN="$GOPATH"/bin
export PATH="$PATH:$GOBIN"

ulimit -c 0 # not sure if this still works after systemd.
#export JDK_HOME=/usr/java/j2sdk1.4.1_01
export CDPATH=.:/home/patola:/dados

function fortunate() {
  set -A fortunas $(cd /usr/share/games/fortunes && ls *.dat off/*.dat | sed 's/\.dat$//')

  a=$((RANDOM%($#fortunas)+1))
  fortuna=$fortunas[$a]

  echo -e "\n---------------------------------\n - TEMA - $fortuna\n---------------------------------\n"
  fortune $fortuna
}

#[ "x$TERM" = "xxterm" ] && TERM=linux

## by Patola: ligar debug pra completions:
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
#

# By Patola - enhances zsh completion
### If you want zsh's completion to pick up new commands in $path automatically
### comment out the next line and un-comment the following 5 lines
#zstyle ':completion:::::' completer _complete _approximate
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1	# Because we didn't really complete anything
}
zstyle ':completion:::::' completer _force_rehash _complete _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes


fpath=($fpath ~/zshcomp)
autoload -U ~/zshcomp/*(:t)
compdef _command launch

# Ctrl-X Ctrl-E to edit current line in vi
autoload -z edit-command-line
zle -N edit-command-line
bindkey "" edit-command-line
# in vi mode:
bindkey -M vicmd v edit-command-line

#export PATH="$PATH":~/bin

# http://www.linux.com/archive/feed/53781
#    * LC_TIME: time format
#    * LC_PAPER: paper size
#    * LC_NAME: personal name format
#    * LC_ADDRESS: address format
#    * LC_TELEPHONE: telephone number format
#    * LC_MEASUREMENT: measurement units
#    * LC_MONETARY: money format
# Locale format: language(_territory)(.encoding)(@modifier), e.g. pt_BR.UTF-8 or es_ES@euro

ling() {
  export LC_ALL=$1
  export LANG=$1
  export LC_COLLATE=$1
  export LANGUAGE=$1
}

# essh
_essh() { compadd `awk '($1!~/^#/) {print tolower($2),tolower($3),tolower($4)}' /etc/hosts` patola.org; }
compdef _essh essh
# OBS.: these two lines could simply be "compdef _hosts essh", but it wouldn't include patola.org.

# by Patola: Fix for slow path completion
zstyle ':completion:*' path-completion false

# Last command on window title:
#[[ "x$TERM" == "xrxvt" || "x$XTERM_VERSION" == xXTerm* || "x$COLORTERM" == 'gnome-terminal' && "x$SHELL" == */bin/zsh ]] && preexec () { print -Pn "\e]0;$1\a" }

# Make SDL audio work properly with Pulse
export SDL_AUDIODRIVER=pulse

# syntax highlighting in less
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '
#export LS_COLORS='rs=0:di=01;36:ln=01;36:mh=00:pi=40;33:so=01;35:do=05;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;40:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'


xhost +local:local

# by Patola - no exclamation mark substitution
unsetopt BANG_HIST
# by Patola - update prompt every minute, starting from the next minute
_prompt_and_resched() { sched +60 _prompt_and_resched; zle && zle reset-prompt }
sched +$(( 60 - $(date '+%S') ))  _prompt_and_resched

export XTERM=xterm-256color

# by Patola - disable caps lock
/usr/bin/setxkbmap -option caps:none
