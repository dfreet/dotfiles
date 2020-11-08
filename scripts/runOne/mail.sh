#!/bin/bash

bridge=$(pgrep protonmail)
thunderbird=$(pgrep thunderbird)
echo $bridge
echo $thunderbird

if [ -z "$bridge" ]
then
	protonmail-bridge &
	sleep 6
	bridge=$(pgrep protonmail)
fi

if [ -z "$thunderbird" ]
then
	thunderbird
	kill $bridge
else
	i3-msg workspace "10 "
fi

