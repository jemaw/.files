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
feh --bg-center ~/Bilder/Wallpapers/fog.jpg &
compton -cC &
setxkbmap -layout eu -option ctrl:nocaps &
xset -dpms &
xset s off &
xset m 0 0 & #übergangslösungen
redshift -l 48.139:11.566 &
exec awesome


# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
