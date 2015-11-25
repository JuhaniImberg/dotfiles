#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi


u_xmodmap=$HOME/.Xmodmap
u_xresources=$HOME/.Xresources

if [ -f "$u_xmodmap" ]; then
    xmodmap "$u_xmodmap"
fi

if [ -f "$u_xresources" ]; then
    xrdb -merge "$u_xresources"
fi

xrandr --dpi 96

exec i3
