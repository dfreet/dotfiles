#!/usr/bin/env bash

res=$( xdpyinfo | awk '/dimensions/{print $2}' )
wallpaper="/home/devyn/pictures/wallpapers/wallpaper_$res.png"
feh --bg-scale $wallpaper

