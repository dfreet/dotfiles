#!/bin/bash

volumeLogos=( "🔇" "🔈" "🔉" "🔊" )

if [ "$1" = "1" ]; then
	amixer -q sset Master,0 toggle
elif [ "$1" = "3" ]; then
	amixer -q sset Master,0 mute
elif [ "$1" = "4" ]; then
	pactl set-sink-volume @DEFAULT_SINK@ +1%
elif [ "$1" = "5" ]; then
	pactl set-sink-volume @DEFAULT_SINK@ -1%
fi

data=$( amixer sget Master | grep "Front Right:" | grep -oP "\[.*\]" )
volume=$( echo $data | grep -oP "\[\d{1,3}\%]" | grep -oP "\d{1,3}" )
state=$( echo $data | grep -oP "on|off" )

if [ "$state" = "on" ]; then
	n=$(( $volume - 2 ))
	logo=$(( ${n#-} / 33 + 1 ))
	if [ $volume -gt 100 ]; then color="#ff0000"; else color="#ffffff"; fi
	volume="$volume%"
else
	logo=0
	color="#00ff00"
	volume="[$volume%]"
fi

echo "<span foreground='$color'>${volumeLogos[$logo]} $volume</span>"

