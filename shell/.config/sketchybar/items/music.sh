#!/bin/bash

music=(
  script="$PLUGIN_DIR/music.sh"
  # icon=􁁒
  icon.drawing=off
  label="Music"
  scroll_texts=false
  icon.padding_left=36
  --subscribe music media_change system_woke
)

sketchybar \
  --add item music right \
  --set music "${music[@]}"
