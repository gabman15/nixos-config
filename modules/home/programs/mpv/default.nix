{ pkgs, lib, config, inputs, ... }:

with lib; let
  cfg = config.custom.home.programs.mpv;
in
  {
    options.custom.home.programs.mpv = {
      enable = mkEnableOption "mpv video player";
    };

    config = mkIf cfg.enable {
      programs.mpv = {
        enable = true;

        scripts = [
          inputs.mpv-remote-node.packages.${pkgs.system}.mpv-remote-script
        ];
        config = {
          # script-opts = "mpvremote.";
          screenshot-directory = "/home/${config.home.username}/pictures/screenshots/mpv";
        };
      };
    };
  }
