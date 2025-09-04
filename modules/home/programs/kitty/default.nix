{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.kitty;
in
  {
    options.custom.home.programs.kitty = {
      enable = mkEnableOption "kitty terminal";
    };

    config = mkIf cfg.enable {
      programs.kitty = {
        enable = true;
        settings = {
          wayland_enable_ime = "yes"; # req version>=0.35.0
          enable_audio_bell = "no";
        };
      };      
    };
  }
