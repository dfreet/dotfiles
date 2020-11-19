#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


if [ ! -z "$( cmp $DIR/us_custom /usr/share/X11/xkb/symbols/us )" ]
then
	BACKUP_DIR=/usr/local/share/keyboard/us_$(date '+%Y%m%d_%H%M%S')
	sudo mkdir -p /usr/local/share/keyboard
	sudo cp /usr/share/X11/xkb/symbols/us $BACKUP_DIR
	sudo cp $DIR/us_custom /usr/share/X11/xkb/symbols/us
	echo "Us keyboard layout changed.  Old layout is at $BACKUP_DIR."
else
	echo "Keyboard layout is correct."
fi

