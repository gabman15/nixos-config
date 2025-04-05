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
          menu = "${pkgs.rofi-wayland}/bin/rofi run -show drun";
          modifier = "Mod4";
          input = {
            "type:touchpad" = {
	            accel_profile = "adaptive";
	            click_method = "clickfinger";
	            scroll_factor = "0.5";
	          };
          };
          output = {
            eDP-1 = {
              scale = "1";
            };
          };

          window.hideEdgeBorders = "smart";
          window.border = 2;
          floating.border = 2;
          window.titlebar = false;
          floating.criteria = [
            { app_id = "mpv"; }
            { app_id = "feh"; }
            { window_role = "pop-up"; }
            { window_role = "bubble"; }
          ];
          
          bars = [];

          keybindings = let
            screenshot-script = (import ./scripts/screenshot.nix) pkgs config;
            modifier = config.wayland.windowManager.sway.config.modifier;
          in lib.mkOptionDefault {
            "${modifier}+Shift+x" = "exec ${pkgs.swaylock}/bin/swaylock";
            "${modifier}+p" = "exec ${pkgs.rofi-pass-wayland}/bin/rofi-pass";
            "${modifier}+Shift+s" = "exec ${screenshot-script}";
            "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +10%";
            "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -10%";
            "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          };
        };
      };
      programs.swaylock = {
        enable = true;
      };
    };
  }
