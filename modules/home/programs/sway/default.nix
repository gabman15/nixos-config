{ inputs, pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.sway;
in
  {
    options.custom.home.programs.sway = {
      enable = mkEnableOption "sway wm";
    };

    config = mkIf cfg.enable {
      stylix.targets.sway.enable = false;
      wayland.windowManager.sway =
        {
          enable = true;
          xwayland = true;

          config = with config.lib.stylix.colors.withHashtag; let
            text = base05;
            urgent = base08;
            focused = base0C;
            unfocused = base03;

            fonts = {
              names = [ config.stylix.fonts.sansSerif.name ];
              size = config.stylix.fonts.sizes.desktop + 0.0;
            };
            background = base00;
            indicator = base0B;
          in {
            inherit fonts;
            colors = {
              inherit background;
              urgent = {
                inherit background indicator text;
                border = urgent;
                childBorder = urgent;
              };
              focused = {
                inherit background indicator text;
                border = focused;
                childBorder = focused;
              };
              focusedInactive = {
                inherit background indicator text;
                border = unfocused;
                childBorder = unfocused;
              };
              unfocused = {
                inherit background indicator text;
                border = unfocused;
                childBorder = unfocused;
              };
              placeholder = {
                inherit background indicator text;
                border = unfocused;
                childBorder = unfocused;
              };
            };
            terminal = "${pkgs.kitty}/bin/kitty";
            menu = "${pkgs.rofi-wayland}/bin/rofi run -show drun -display-drun 'drun: '";
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
            startup = mkIf config.custom.home.programs.backgrounder.enable [
              {
                command = "${inputs.gabe-backgrounder.packages.${pkgs.system}.default}/bin/gabe-backgrounder -c ${config.age.secrets.backgrounder-config.path}";
                always = true;
              }
            ];
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
