{
  bar_top = {
    layer = "top";
    position = "top";
    height = 40;
    
    modules-left = [ "pulseaudio" "memory" "cpu" ];
    modules-center = [ "clock" ];
    modules-right = [ "disk" ];
  };
  bar_bottom = {
    layer = "top";
    position = "bottom";
    height = 40;
    modules-left = [ "battery" "network" ];
    modules-center = [ "sway/workspaces" ];
    modules-right = [ "sway/mode" ];
  };
}
