{ lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.mpd;
in
  {
    options.custom.home.programs.mpd = {
      enable = mkEnableOption "mpd service";
    };

    config = mkIf cfg.enable {
      services.mpd = {
        enable = true;
        musicDirectory = "/mnt/music";
        playlistDirectory = "/mnt/music/playlists";
        extraConfig = ''
          audio_output {
            type "pipewire"
            name "PipeWire Sound"
          }
        '';
      };
    };
  }
