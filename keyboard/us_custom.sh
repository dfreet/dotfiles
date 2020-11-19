#!/bin/bash

while :
do
	if [ ! -z "$(cmp /usr/local/share/keyboard/us_custom /usr/share/X11/xkb/symbols/us)" ]
	then
		BACKUP_DIR=/usr/local/share/keyboard/us_$(date '+%Y%m%d_%H%M%S')
		cp /usr/share/X11/xkb/symbols/us $BACKUP_DIR
		cp /usr/local/share/keyboard/us_custom /usr/share/X11/xkb/symbols/us
		echo "keyboard.service: Us keyboard layout changed.  Old layout is at $BACKUP_DIR" | systemd-cat -p info
		sleep 540
	fi
	sleep 60
done

