#!/usr/bin/env bash

res=$( xdpyinfo | awk '/dimensions/{print $2}' )
wallpaper="$HOME/pictures/wallpapers/wallpaper_$res.png"
feh --bg-scale --no-xinerama $wallpaper

