#!/usr/bin/env bash
function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

xmodmap ~/.Xmodmap
touchpad=`xinput list|grep SynPS`
xinput --disable ${touchpad:50:2}

run firefox
run nm-applet
if ! pgrep dropbox ; then
    dbus-launch ~/.local/bin/dropbox start -i
fi
compton --config ~/.config/compton.conf
