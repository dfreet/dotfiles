#!/usr/bin/env bash

symbol="🎵"
grey="#999999"
green="#00ff66"
status=$( mpc 2>&1 )

if [ "$1" = "1" ];
then
	mpc toggle
fi

if [ $? -eq 0 ];
then
	songText=$( mpc current )
	status=$( mpc | grep -oP "(?<=\[)\w+" )
	if [[ ! -z "$songText" ]] && [[ ! -z "$status" ]];
	then
		if [ "$status" = "playing" ];
		then
			echo "<span foreground='$green'>$symbol $songText</span>"
		elif [ "$status" = "paused" ];
		then
			echo "<span foreground='$grey'>$symbol $songText</span>"
		fi
	fi
fi

