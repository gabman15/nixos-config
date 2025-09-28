{
  bar_top_left = {
    layer = "top";
    position = "top";
    height = 40;
    output = "Acer Technologies XV272U 0x1121BA45";
    modules-left = [ "pulseaudio" "memory" "cpu" "temperature" ];
    modules-center = [ "clock" "custom/weather" ];
    modules-right = [ "disk" "disk#games" "disk#anime" ]; # + weather + package update?
  };
  bar_top_right = {
    layer = "top";
    position = "top";
    height = 40;
    output = "Dell Inc. DELL E2414H VJH96522A4TU";
    modules-left = [ "custom/mpd-button" "mpd" ];
    modules-right = [ "clock" ];
  };
  bar_bottom = {
    layer = "top";
    position = "bottom";
    height = 40;
    modules-left = [ "network" "backgrounder" ];
    modules-center = [ "sway/workspaces" ];
    modules-right = [ "sway/mode" ];
  };
}
