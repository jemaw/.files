#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# wallpaper
~/.fehbg

# start redshift
redshift -l 48.139:11.566 &

# Megasync
( ( sleep 2 && /usr/bin/megasync ) & )

# composite manager
compton --config "$HOME/.config/compton/compton.conf" -b &

# pulseaudio systray
pasystray &

xset -dpms &
xset s 0 &
xset r rate 220 30 &

# eurkey with caps as ctrl
setxkbmap eu -option caps:ctrl_modifier &

# enable numlock (needs numlockx installed)
numlockx &

# xrandr --output DVI-I-1 --mode 1920x1080 --rate 60.00 &
# xrandr --output DP-1 --mode 1920x1080 --rate 119.98 --right-of DVI-D-0 &
( (grep '^Exec' .config/autostart/lxrandr-autostart.desktop | tail -1 | sed 's/^Exec=//' | sed 's/%.//' | sed 's/^"//g' | sed 's/" *$//g' | sh -) & )

eval "$(ssh-agent)"

exec awesome 
