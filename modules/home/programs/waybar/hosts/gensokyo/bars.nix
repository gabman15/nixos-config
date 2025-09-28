{
  bar_top_left = {
    layer = "top";
    position = "top";
    height = 40;
    output = "DP-4";
    modules-left = [ "pulseaudio" "memory" "cpu" "temperature" ];
    modules-center = [ "clock" ];
    modules-right = [ "disk" "disk#games" "disk#anime" ]; # + weather + package update?
  };
  bar_top_right = {
    layer = "top";
    position = "top";
    height = 40;
    output = "DVI-D-1";
    modules-left = [ "custom/mpd-button" "mpd" ];
    modules-right = [ "clock" ];
  };
  bar_bottom = {
    layer = "top";
    position = "bottom";
    height = 40;
    modules-left = [ "network" "backgrounder" ];
    modules-center = [ "sway/workspaces" ];
    modules-right = [];
  };
}
