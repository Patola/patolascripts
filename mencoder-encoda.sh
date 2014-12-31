#!/bin/zsh

find . -name '*.mp4' | while read f                               
do
g="${f%.*}.avi"
mencoder "$f" -sid 999 -ovc xvid -oac mp3lame -lameopts cbr:br=192 -xvidencopts pass=1:bitrate=500000 -o /dev/null
#mencoder "$f" -sid 999 -ovc xvid -oac mp3lame -lameopts cbr:br=192 -xvidencopts pass=2:bitrate=500000:threads=4 -o "$g" && rm "$f"
mencoder "$f" -sid 999 -ovc xvid -oac mp3lame -lameopts cbr:br=192 -xvidencopts pass=2:bitrate=500000:threads=4 -o "$g" && rm "$f"

done

