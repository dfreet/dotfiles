#!/usr/bin/env bash

wlan=$(iwctl station wlan0 show)
state=$(echo "$wlan" | grep -oP '(?<=State\s{15})\S*')

if [[ "$state" == "connected" ]]
then
	network=$(echo "$wlan" | grep -oP '(?<=Connected network\s{3})\S*')

	ping=$( ping -c 3 www.devynfreet.com | grep -oP '(?<=\/)\d+\.?\d*(?=\/)' | head -1 | grep -oP '^\d+' )

	echo " $network: $ping"
elif [[ "$state" == "disconnected" ]]
then
	echo "<span foreground='grey'> --</span>"
else
	echo "<span foreground='red'> XX</span>"
fi

