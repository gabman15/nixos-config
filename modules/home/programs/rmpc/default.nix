{ lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.rmpc;
  mkIfElse = p: yes: no: mkMerge [
    (mkIf p yes)
    (mkIf (!p) no)
  ];
in
  {
    options.custom.home.programs.rmpc = {
      enable = mkEnableOption "rmpc mpd client";
      badterm = mkEnableOption "using wsl or terminal that doesn't report size";
    };

    config = mkIf cfg.enable {
      programs.rmpc = let
        normal-max-size-px = ["max_size_px: (width: 0, height: 0)"];
        wsl-max-size-px = ["max_size_px: (width: 400, height: 400)"];
        init-config-file = builtins.readFile ./config.ron;
        wsl-config-file = builtins.replaceStrings normal-max-size-px wsl-max-size-px init-config-file;
        config-file = mkIfElse cfg.badterm wsl-config-file init-config-file;
      in
        {
          enable = true;
          config = config-file;
        };
    };
  }
