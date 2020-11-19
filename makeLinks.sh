#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

CONF=$HOME/.config
mkdir -p $CONF
for filename in $DIR/config/*; do
	outfile=$CONF/$( echo $filename | grep -oP [^\/]+$ )
	if [ -a $outfile ] && ! [ -h $outfile ]; then echo "File $outfile exists." && exit 1; fi
	ln -sfn $filename $outfile && echo "$filename -> $outfile"
done
printf "Config files linked\n\n"

mkdir -p $HOME/scripts
if [ -a $HOME/scripts/dotfiles ] && ! [ -h $HOME/scripts/dotfiles ]; then
	echo "File $HOME/scripts/dotfiles exists." && exit 1
fi
ln -sfn $DIR/scripts $HOME/scripts/dotfiles && echo "$DIR/scripts -> $HOME/scripts/dotfiles"
printf "Scripts linked \n\n"

for filename in $DIR/terminal/*; do
	outfile=$HOME/.$( echo $filename | grep -oP [^\/]+$ )
	echo $outfile
	if [ -a $outfile ] && ! [ -h $outfile ]; then echo "File $outfiles exists." && exit 1; fi
	ln -sfn $filename $outfile && echo "$filename -> $outfile"
done
printf "Terminal files linked\n\n"

mkdir -p $HOME/pictures
if [ -a $HOME/pictures/wallpapers ] && ! [ -h $HOME/pictures/wallpapers ]; then
	echo "File $HOME/pictures/wallpapers exists." && exit 1
fi
ln -sfn $DIR/wallpapers $HOME/pictures/wallpapers && echo "$DIR/wallpapers -> $HOME/pictures/wallpapers"
printf "Wallpapers linked\n\n"

$DIR/keyboard/setLayout.sh

