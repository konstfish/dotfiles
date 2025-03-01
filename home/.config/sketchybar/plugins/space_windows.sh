#!/usr/bin/env bash

source "$HOME/.config/sketchybar/plugins/icon_map.sh"

update_space_windows() {
  SPACE=$1
  QUERY=$(yabai -m query --windows --space $SPACE)
  APPS=$(echo "$QUERY" | jq -r '.[] | select(."is-minimized"==false) | .app' | sort)
  
  APP_ICONS=""
  
  for APP in $APPS; do
    __icon_map "$APP"
    if [[ -n "$icon_result" ]]; then
      APP_ICONS+="$icon_result "
    fi
  done
  
  if [[ -n "$APP_ICONS" ]]; then
    sketchybar --set space.$SPACE label="$APP_ICONS"
  else
    sketchybar --set space.$SPACE label=""
  fi
}

SPACES=$(yabai -m query --spaces | jq -r '.[] | .index')

for SPACE in $SPACES; do
  update_space_windows $SPACE
done