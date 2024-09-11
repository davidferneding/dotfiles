#!/bin/bash

outlook=(
    icon=":microsoft_outlook:"
    icon.font="sketchybar-app-font:Regular:16.0"
    label.padding_left=-2
    label.color=$RED
    script="$PLUGIN_DIR/outlook.clj"
    update_freq=3
)

sketchybar --add item outlook right     \
           --set outlook "${outlook[@]}"  \
