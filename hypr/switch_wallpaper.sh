directory=~/Pictures/Wallpapers
monitor=`hyprctl monitors | grep Monitor | awk '{print $2}'`
current_background=$(grep -oP '(?<=wallpaper = eDP-1,/home/josh/Pictures/Wallpapers/).*' ~/.config/hypr/hyprpaper.conf)

while true; do
  if [ -d "$directory" ]; then
    random_background=$(find "$directory" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | shuf -n 1)
    if [ "$random_background" != "$current_background" ]; then
      hyprctl hyprpaper unload all
      hyprctl hyprpaper preload $random_background
      hyprctl hyprpaper wallpaper "$monitor, $random_background"

      current_background="$random_background"
    else
      continue
    fi
  fi
  sleep 360 
done
