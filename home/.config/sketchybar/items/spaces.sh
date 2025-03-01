# spaces
SPACES=$(yabai -m query --spaces | jq -r '.[] | .index')
for i in $SPACES
do
  sketchybar --add space space.$i left \
             --set space.$i associated_space=$i \
                          icon=$i \
                          label.drawing=on \
                          icon.padding_left=8 \
                          icon.padding_right=8 \
                          background.color=0x40ffffff \
                          background.corner_radius=5 \
                          background.height=24 \
                          icon.drawing=off \
                          icon.font="$LABEL_FONT" \
                          label.font="sketchybar-app-font:Normal:14.0" \
                          script="$PLUGIN_DIR/space.sh" \
                          background.drawing=off \
                          click_script="yabai -m space --focus $i"
done

sketchybar --add item space_windows_subscriber left
sketchybar --set space_windows_subscriber drawing=off script="$PLUGIN_DIR/space_windows.sh"

sketchybar --subscribe space_windows_subscriber space_windows_change

# init windows
"$PLUGIN_DIR/space_windows.sh"