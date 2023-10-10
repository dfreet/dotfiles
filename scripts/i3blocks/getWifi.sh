#!/usr/bin/env bash

#TODO: Set up ethernet detection
state=$( iwctl station wlan0 show )
reState="State\s+(\S+)"
reNetwork="Connected network\s+(\S+)"
reEth="(\S.+\S)\s+[0-9a-z-]{36}\s+ethernet"
reNmWifi="(\S.+\S)\s+[0-9a-z-]{36}\s+wifi"
wifiSym=""
ethSym=""

if [[ $state =~ $reState ]]
then
	if [[ ${BASH_REMATCH[1]} == "connected" ]]
	then
		if [[ $state =~ $reNetwork ]] 
		then
			network=${BASH_REMATCH[1]}
			#ping=$( ping -c 3 archlinux.org | grep -oP '(?<=\/)\d+\.?\d*(?=\/)' | head -1 | grep -oP '^\d+' )
			echo "<span foreground='white'>$wifiSym $network</span>"
			exit 1
		fi
	fi
fi
nmcli=$( nmcli c show -a | tail -n +2 )
if [[ $nmcli =~ $reEth ]]
then
	network=${BASH_REMATCH[1]}
	#ping=$( ping -c 3 archlinux.org | grep -oP '(?<=\/)\d+\.?\d*(?=\/)' | head -1 | grep -oP '^\d+' )
	echo "<span foreground='white'>$ethSym $network</span>"
elif [[ $nmcli =~ $reNmWifi ]]
then
	network=${BASH_REMATCH[1]}
	#ping=$( ping -c 3 archlinux.org | grep -oP '(?<=\/)\d+\.?\d*(?=\/)' | head -1 | grep -oP '^\d+' )
	echo "<span foreground='white'>$wifiSym $network</span>"
else
	echo "<span foreground='grey'>$wifiSym --</span>"
fi

