#!/usr/bin/env bash

lastUpdate=$( cat /var/log/pacman.log | grep "starting full system upgrade" | tail -1 | grep -oP "\[\K\S*(?=-\d{4})" )

curDate=$( date -d "$(date)" "+%s" )
updDate=$( date -d "$lastUpdate" "+%s" )
diff=$(( ( $curDate - $updDate ) ))
hours=$(( $diff / 3600 ))
minutes=$(( ( $diff - $hours * 3600 ) / 60 ))
seconds=$(( $diff - ( $hours * 3600 + $minutes * 60 ) ))

if [ $hours -gt 12 ]
then
	echo " have you -Syu'd today?"
fi

