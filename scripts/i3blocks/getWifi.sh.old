#!/usr/bin/env bash

conns=$( nmcli c show -a )
network=$( echo "$conns" | grep -P '^.*\s(wifi|ethernet)(?!\s*--\s*$).*$')

if [ -z "$network" ]
then
	echo "<span foreground='grey'> --</span>"
else
	nameCol=$(( $( echo "$conns" | grep -oP 'NAME\s*' | wc -c ) - 1 ))
	uuidCol=$(( $( echo "$conns" | grep -oP 'UUID\s*' | wc -c ) - 1 ))
	typeCol=$(( $( echo "$conns" | grep -oP 'TYPE\s*' | wc -c ) - 1 ))

	name=$( echo ${network:0:nameCol} | grep -oP '.*\S(?=\s*$)' )
	connType=$( echo ${network:$(( nameCol + uuidCol )):typeCol} | grep -oP '.*\S(?=\s*$)' )

	ping=$( ping -c 3 www.devynfreet.com | grep -oP '(?<=\/)\d+\.?\d*(?=\/)' | head -1 | grep -oP '^\d+' )

	sym=$( [ "$connType" == "ethernet" ] && echo "" || echo "" )
	echo "$sym $name: $ping"
fi

