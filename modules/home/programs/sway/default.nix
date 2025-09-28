{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.sway;
in
  {
    options.custom.home.programs.sway = {
      enable = mkEnableOption "sway wm";
    };

    config = mkIf cfg.enable {
      wayland.windowManager.sway = {
        enable = true;
        xwayland = true;
        config = {
          terminal = "${pkgs.kitty}/bin/kitty";
          menu = "${pkgs.rofi-wayland}/bin/rofi run -show drun -font 'Hack 12'";
          modifier = "Mod4";
          input = {
            "type:touchpad" = {
	            accel_profile = "adaptive";
	            click_method = "clickfinger";
	            scroll_factor = "0.5";
	          };
          };
          keybindings = let
            modifier = config.wayland.windowManager.sway.config.modifier;
          in lib.mkOptionDefault {
            "${modifier}+Shift+x" = "exec ${pkgs.swaylock}/bin/swaylock";
          };
        };
      };
      programs.swaylock = {
        enable = true;
      };
    };
  }
