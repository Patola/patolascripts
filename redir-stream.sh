#!/bin/bash - 
#===============================================================================
#
#          FILE: redir-stream.sh
# 
#         USAGE: ./redir-stream.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Cláudio "Patola" Sampaio (Patola), patola@gmail.comm
#  ORGANIZATION: MakerLinux
#       CREATED: 04/10/2020 09:05:26 CEST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# get list of sinks/cards (for settings CARD1/CARD2)
# pacmd list-sinks | awk '/name:/ {print $0};' | awk '{ print $2}' | sed 's/<//g; s/>//g'

#CARD1="alsa_output.usb-C-Media_INC._C-Media_USB_Audio-00"
#CARD2="alsa_output.usb-Kingston_HyperX_Virtual_Surround_Sound_00000000-00"
#CARD1="alsa_output.pci-0000_2d_00.1.hdmi-stereo"
CARD1="alsa_output.pci-0000_2d_00.1"
CARD2="bluez_sink.FC_58_FA_A4_91_EE.a2dp_sink"
CARD3="alsa_output.pci-0000_2f_00.4"

CURRENT_SINK=$(pacmd stat | awk -F": " '/^Default sink name: /{print $2}' | awk 'BEGIN{FS=OFS="."} NF--' | sed 's/alsa_output/alsa_output/g')


function setCard() {

  if [ "$CURRENT_SINK" == "$1" ]
   then
     echo "Already using this Sink"
     exit 1
  fi

  NEW_SINK=$(pacmd list-sinks | awk '/index:/ {print $1 $2 $3} /name:/ {print $0};' | grep -m1 -B1 $1 | grep index | awk '{print $1}' | cut -d ":" -f2)
  SINK=$(pacmd set-default-sink $NEW_SINK)
  INPUT=$(pacmd list-sink-inputs | grep index | awk '{print $2}')

  pacmd move-sink-input $INPUT $NEW_SINK
  echo "Moving input: $INPUT to sink: $NEW_SINK";
  echo "Setting default sink to: $NEW_SINK";

  notify-send --urgency=low "Audio Switching" "SINK: $NEW_SINK"
}

function toggleSinks() {
  if [ "$CURRENT_SINK" == "$CARD1" ]
    then
      setCard $CARD2
    else
      setCard $CARD1
    fi
}


function showHelp() {
  echo "------------------------------------"
  echo "AUDIO SINK SWITCHER"
  echo " "
  echo "$0 [options]"
  echo " "
  echo "options:"
  echo "-h  --help        What you are looking at.."
  echo "-g, --gaming      Sets Gaming headset as output device"
  echo "-v. --valve       Sets Valve Index as output device"
  echo "-s, --speakers    Sets Speakers as output device"
  echo "-t, --toggle      Toggles the different output devices"
  echo " "
  echo "------------------------------------"
}

# check args length
if [ $# -eq 0 ]
  then
    echo "Toggling output devices (Speakers/Headset)"
    toggleSinks
fi


# arg options
while test $# -gt 0; do
    case "$1" in

                -h|--help)
                        showHelp
                        exit 1
                        ;;

                -g|--gaming)
                        setCard $CARD2
                        exit 1
                        ;;

                -s|--speakers)
                        setCard $CARD3
                        exit 1
                        ;;

                -v|--valve)
                        setCard $CARD1
                        exit 1
                        ;;

                -t|--toggle)
                        toggleSinks
                        echo "Toggling output devices (Speakers/Headset)"
                        exit 1
                        ;;
                 *)
                        showHelp
                        exit 1
                        ;;
    esac
done

