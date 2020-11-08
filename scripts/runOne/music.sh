#!/bin/bash

running=$(pgrep "spotify")
echo $running

if [ -z "$running" ]
then
	exec spotify
else
	i3-msg workspace "9 "
fi

