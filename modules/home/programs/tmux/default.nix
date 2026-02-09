{ lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.tmux;
in
  {
    options.custom.home.programs.tmux = {
      enable = mkEnableOption "tmux";
    };

    config = mkIf cfg.enable {
      programs.tmux = {
        enable = true;
      };
    };
  }
