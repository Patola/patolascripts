#!/bin/zsh
first="$1"
second="$2"
[ "x$second" = "x" ] && second=.
shift; shift

if [[ "$first" == *.srt || "$first" == *.sub ]]
then
  temp="$first"
  first="$second"
  second="$temp"
fi

[[ $first == *. ]] && {
  first="$(eval echo "${first}"(mkv|avi|mpg|mpeg|mov|mp4))"
  echo "'$first'"
}


/usr/bin/xset s off
/usr/bin/xset -dpms
# Is Guake running?
/usr/bin/qdbus | /bin/grep -q org.guake.RemoteControl && {
  /usr/bin/qdbus org.guake.RemoteControl /org/guake/RemoteControl org.guake.RemoteControl.show_hide
} || { /usr/bin/qdbus | /bin/grep -q org.kde.yakuake && {
  /usr/bin/qdbus org.kde.yakuake /yakuake/MainWindow_1 org.qtproject.Qt.QWidget.hide
  } || {
    /usr/bin/qdbus | /bin/grep -q org.terraterminal.RemoteControl && {
      /usr/bin/qdbus org.terraterminal.RemoteControl /org/terraterminal/RemoteControl org.terraterminal.RemoteControl.show_hide
    }
  }
}


#/usr/bin/mplayer -ao pulse "$first" -sub "$second" -framedrop -ass -ass-color FFFF0000 -ass-font-scale 1 -ass-force-style FontName=Vera,Default.Bold=1 "$@"
/usr/bin/mplayer -ao pulse "$first" -sub "$second" -framedrop "$@"

/usr/bin/qdbus | /bin/grep -q org.guake.RemoteControl && {
  /usr/bin/qdbus org.guake.RemoteControl /org/guake/RemoteControl org.guake.RemoteControl.show_hide
} || { /usr/bin/qdbus | /bin/grep -q org.kde.yakuake && {
  /usr/bin/qdbus org.kde.yakuake /yakuake/MainWindow_1 org.qtproject.Qt.QWidget.show
  } || {
    /usr/bin/qdbus | /bin/grep -q org.terraterminal.RemoteControl && {
      /usr/bin/qdbus org.terraterminal.RemoteControl /org/terraterminal/RemoteControl org.terraterminal.RemoteControl.show_hide
    }
  }
}

/usr/bin/xset +dpms
/usr/bin/xset s on
