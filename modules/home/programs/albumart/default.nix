{ inputs, pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.albumart;
in
  {
    options.custom.home.programs.albumart = {
      enable = mkEnableOption "mpd album art grabber";
      mpd-host = mkOption {
        description = "hostname of mpd server";
        type = with types; nullOr str;
        default = "localhost";
      };
    };

    config = mkIf cfg.enable {
      systemd.user.services.albumart = {
        Unit = {
          Description = "Grabs album art from running mpd daemon";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
        Service = {
          ExecStart = ''
            ${inputs.mpd-albumart.packages.${pkgs.system}.default}/bin/mpd-albumart --host ${cfg.mpd-host}
          '';
        };
      };
    };
  }
