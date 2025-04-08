{ lib, config, ... }:

with lib; let
  cfg = config.custom.home.suites.mpd;
in
  {
    options.custom.home.suites.mpd = {
      enable = mkEnableOption "programs for controlling and listening to mpd daemon";
      mpd-host = mkOption {
        description = "hostname of mpd server";
        type = with types; nullOr str;
        default = "localhost";
      };
    };

    config = mkIf cfg.enable {
      home.packages = [
        (pkgs.writeShellScriptBin "mpv-mpd" ''
          ${pkgs.mpv}/bin/mpv --no-cache http://${mpd-host}:8001
        '')
      ];

      custom.home.programs.albumart.enable = true;
      custom.home.programs.albumart.mpd-host = mpd-host;
    };
  }
