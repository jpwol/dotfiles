#!/usr/bin/fish

set directory ~/Pictures/Wallpapers/
set monitors (hyprctl monitors | grep Monitor | awk '{print $2}')
set current_background (grep -oP '(?<=wallpaper = $monitors[1],$directory).*' ~/.config/hypr/hyprpaper.conf)

while true
  if test -d $directory
    set random_background (find "$directory" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | shuf -n 1)

    if test "$random_background" != "$current_background"
      hyprctl hyprpaper unload all
      hyprctl hyprpaper preload $random_background

      for monitor in $monitors
        hyprctl hyprpaper wallpaper $monitor, $random_background
      end

      set current_background $random_background
    else
      continue
    end
  end
  sleep 10
end
