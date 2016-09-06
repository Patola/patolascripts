#!/bin/zsh
# cvlc 'http://10.0.0.100:81/videostream.cgi?user=admin&pwd=888888'
mpv 'rtsp://10.0.0.50:2002/user=admin&password=&channel=1&stream=0.sdp?real_stream--rtp-caching=100'
