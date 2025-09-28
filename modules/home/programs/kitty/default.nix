{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.kitty;
  colorscheme = import ../../opts/colorscheme/gruvbox_dark.nix;
in
  {
    options.custom.home.programs.kitty = {
      enable = mkEnableOption "kitty terminal";
    };

    config = mkIf cfg.enable {
      programs.kitty = {
        enable = true;

        font = {
          name = "Hack Regular";
          package = pkgs.hack-font;
          size = 18;
        };

        settings = {
          wayland_enable_ime = "yes"; # req version>=0.35.0

          # usage
          enable_audio_bell = "no";

          inherit (colorscheme.terminal)
            foreground
            background
            cursor
            selection-foreground
            selection-background

            color0
            color1
            color2
            color3
            color4
            color5
            color6
            color7
            color8
            color9
            color10
            color11
            color12
            color13
            color14
            color15;
        };
      };      
    };
  }
