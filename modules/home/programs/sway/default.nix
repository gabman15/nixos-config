{ inputs, pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.sway;
in
  {
    options.custom.home.programs.sway = {
      enable = mkEnableOption "sway wm";
      sys-swaylock = mkEnableOption "use system swaylock";
      sys-kitty = mkEnableOption "use system kitty";
    };

    config = mkMerge [
      (mkIf cfg.enable {
        wayland.windowManager.sway =
          {
            enable = true;
            xwayland = true;

            config = let
              exit = "exit: [p]oweroff, [r]eboot, [l]ogout";
            in {
              terminal = mkIfElse cfg.sys-kitty "kitty" "${pkgs.kitty}/bin/kitty";
              menu = "${pkgs.rofi-wayland}/bin/rofi run -show drun -display-drun 'drun: '";
              modifier = "Mod4";
              input = {
                "type:touchpad" = {
                  accel_profile = "adaptive";
                  click_method = "clickfinger";
                  scroll_factor = "0.5";
                };
                "type:pointer" = {
                  accel_profile = "flat";
                };
              };
              # Thanks jbwar22 for the screens opt handling code
              output = foldl' (accum: screen: accum // (let
                screen-def = screen.value.sway;
              in {
                "${screen.name}" = screen-def;
              })) {
                "*" = {
                  scale = "1";
                };
              } (attrsToList config.custom.home.opts.screens);

              window.hideEdgeBorders = "smart";
              window.border = 2;
              floating.border = 2;
              window.titlebar = false;
              floating.criteria = [
                { app_id = "mpv"; }
                { class = "feh"; }
                { window_role = "pop-up"; }
                { window_role = "bubble"; }
              ];
              modes = {
                ${exit} = {
                  p = "exec systemctl poweroff";
                  r = "exec systemctl reboot";
                  l = "exec swaymsg exit";
                  Return = "mode default";
                  Escape = "mode default";
                };
                resize = {
                  Down = "resize grow height 30 px";
                  Left = "resize shrink width 30 px";
                  Right = "resize grow width 30 px";
                  Up = "resize shrink height 30 px";
                  Return = "mode default";
                  Escape = "mode default";
                };
              };
              bars = [];
              startup = mkIf config.custom.home.programs.backgrounder.enable [
                {
                  command = "${inputs.gabe-backgrounder.packages.${pkgs.system}.default}/bin/gabe-backgrounder -c ${config.age.secrets.backgrounder-config.path}";
                  always = true;
                }
              ];
              keybindings = let
                scripts = (import ./scripts) pkgs config;
                modifier = config.wayland.windowManager.sway.config.modifier;
                swaylock = mkIfElse cfg.sys-swaylock "exec swaylock" "exec ${pkgs.swaylock}/bin/swaylock";
              in lib.mkOptionDefault {
                "${modifier}+Shift+x" = swaylock;
                "${modifier}+p" = "exec ${pkgs.rofi-pass-wayland}/bin/rofi-pass";
                "${modifier}+Shift+s" = "exec ${scripts.screenshot}";
                "${modifier}+Shift+t" = "exec ${scripts.translate-screenshot}";
                "${modifier}+g" = "exec ${pkgs.rofi-wayland}/bin/rofi run -show drun -drun-categories Game -show-icons -display-drun 'games: '";
                "${modifier}+Mod1+t" = "exec ${scripts.translate}";
                "${modifier}+Mod1+e" = "mode \"${exit}\"";
                "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +10%";
                "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -10%";
                "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
              };
            };
          };
        programs.swaylock = {
          enable = true;
          package = mkIf cfg.sys-swaylock null;
        };
        services.dunst.enable = true;
        home.packages = [
          pkgs.wl-clipboard
        ];
      })
      (mkIf config.custom.home.opts.stylix ((import ./stylix.nix) config))
    ];
  }
