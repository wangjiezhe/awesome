#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run shutter --min_at_start
run clipit
run nutstore
start-pulseaudio-x11
run pasystray
