{
  bar_top = {
    layer = "top";
    position = "top";
    height = 40;
    
    modules-left = [ "pulseaudio" "memory" "cpu" "temperature" ];
    modules-center = [ "clock" ];
    modules-right = [ "disk" ]; # + weather + package update?
  };
  bar_bottom = {
    layer = "top";
    position = "bottom";
    height = 40;
    modules-left = [ "battery" "network" "backgrounder" ];
    modules-center = [ "sway/workspaces" ];
    modules-right = [ "sway/mode" ];
  };
}
