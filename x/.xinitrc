#!/bin/sh

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
