#!/bin/bash

slack=(
    icon=":slack:"
    icon.font="sketchybar-app-font:Regular:16.0"
    label.padding_left=-2
    label.color=$RED
    script="$PLUGIN_DIR/slack.clj"
    update_freq=3
)

sketchybar --add item slack right     \
           --set slack "${slack[@]}"  \
