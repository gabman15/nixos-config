{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.waybar;
  base_modules = {
    "sway/workspaces" = {
      disable-scroll = true;
    };
    "clock" = {
      interval = 1;
      format = "{:%H:%M:%S - %m.%d.%Y}";
      tooltip-format = "<tt>{calendar}</tt>";
      actions = {
        on-click = "mode";
      };
      calendar = {
        mode = "month";
        mode-mon-col = 3;
        format = {
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
        };
      };
    };
    "battery" = {
      format = "{icon} {capacity}%";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
      ];
    };
    "network" = {
      format-wifi = "{icon} {ipaddr}";
      format-icons = [
        "󰤟"
        "󰤢"
        "󰤥"
        "󰤨"
      ];
      format-ethernet = " {ipaddr}";
    };
    "custom/mpd-button" = let
      mpd-button-script = (import ./scripts/mpd-button.nix) pkgs config;
    in {
      exec = "${mpd-button-script}";
      on-click = "mpc toggle";
      restart-interval = 1;
      tooltip = false;
    };
    "mpd" = {
      tooltip = false;
      format = "{artist} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S})";
      cursor = false;
      # state-icons = {
      #   paused = "";
      #   playing = "";
      # };
    };
    "pulseaudio" = {
      format = "audio: {volume}%";
      format-muted = "audio: muted";
    };
    "memory" = {
      format = "mem: {percentage}%";
    };
    "cpu" = let
      icons = concatStrings (map (x:
        "{icon${toString x}}"
      ) (range 0 15));
    in {
      format = "cpu: ${icons}";
      format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
    };
  };

  host_modules = import ./hosts/${config.custom.home.opts.hostname}/modules.nix;
  host_bars = import ./hosts/${config.custom.home.opts.hostname}/bars.nix;
in
  {
    options.custom.home.programs.waybar = {
      enable = mkEnableOption "waybar status bar";
    };

    config = mkIf cfg.enable {
      stylix.targets.waybar = mkIf config.custom.home.opts.stylix {
        enableLeftBackColors = false;
        enableRightBackColors = false;
        enableCenterBackColors = false;
      };
      home.packages = [
        (pkgs.nerd-fonts.hack)
      ];
      programs.waybar = {
        enable = true;
        systemd.enable = true;
        systemd.target = "sway-session.target";
        style = import ./style.nix;
        settings = mapAttrs (name: value: value // host_modules // base_modules) host_bars;
      };
    };
  }
