#!/bin/zsh
# cvlc 'http://10.0.0.100:81/videostream.cgi?user=admin&pwd=888888'
curl -s 'http://10.0.0.54:81/livestream.cgi?user=admin&pwd=888888&streamid=0&audio=0&filename=' | mplayer -nocache -vc ffh264 -demuxer h264es -fps 15 -noextbased -
