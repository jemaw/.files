#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrandr --output DVI-0 --mode 1920x1080 --rate 119.98 --right-of DVI-1 
xrandr --output DVI-0 --primary

~/.fehbg &
#compton -cC &
#xsetroot -cursor_name left_ptr &

setxkbmap -layout eu -option ctrl:nocaps &
#setxkbmap -layout eu -option caps:escape &

xset -dpms &
xset s off &

#dropbox &
xset m 0 0 & #übergangslösungen
sxhkd -f 120 &
redshift -l 48.139:11.566 &
numlockx on &
xset r rate 200 25 &

exec awesome
#exec bspwm
