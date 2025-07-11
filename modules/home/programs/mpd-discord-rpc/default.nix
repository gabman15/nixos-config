{ lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.mpd-discord-rpc;
in
  {
    options.custom.home.programs.mpd-discord-rpc = {
      enable = mkEnableOption "mpd discord rich presence";
    };

    config = mkIf cfg.enable {
      services.mpd-discord-rpc.enable = true;
    };
  }
