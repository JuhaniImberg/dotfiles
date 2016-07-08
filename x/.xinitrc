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

gpg-connect-agent /bye || true
if [ -e "$HOME/.gnupg/S.gpg-agent.ssh" ]; then
    export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
fi

if command -v redshift; then
    redshift &
fi

if command -v autocutsel; then
    autocutsel -fork &
    autocutsel -selection PRIMARY -fork &
fi

xrandr --dpi 96

if command -v feh; then
    feh --bg-scale ~/Pictures/background.png
fi

if [ -x "$HOME/src/srandrd/srandrd" ]; then
    ~/src/srandrd/srandrd "$HOME/.srandr"
fi

if [ -x "$HOME/.virtualenvs/qtile/bin/qtile" ]; then
    exec ~/.virtualenvs/qtile/bin/qtile
else
    exec i3
fi
