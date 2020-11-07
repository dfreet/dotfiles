#!/usr/bin/env bash

network=$( nmcli c show | grep -P '^.*\s(wifi|ethernet|tun)(?!\s*--\s*$).*$' | grep -oP "^\S*" )
if [ -z "$network" ]
then
	echo " --"
elif [ "$network" == "proton0" ]
then
	echo "<span foreground='red'> Err</span>"
else
	vpnOut=$( timeout 16s protonvpn s | grep -P "Status|Server" )
	vpnStatus=$( echo "$vpnOut" | grep -oP "Status:\s*\K\S*" )
	vpnServer=$( echo "$vpnOut" | grep -oP "Server:\s*\K\S*" )
	
	if [ -z "$vpnStatus" ]
	then
		echo "<span foreground='red'> Err</span>"
	elif [ "$vpnStatus" == "Disconnected" ]
	then
		echo " --"
	else
		echo "<span foreground='#00aa00'> $vpnServer</span>"
	fi
fi

