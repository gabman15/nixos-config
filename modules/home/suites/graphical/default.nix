{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.suites.graphical;
in
  {
    options.custom.home.suites.graphical = {
      enable = mkEnableOption "suite of settings+programs for graphical home manager setups";
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        hack-font
        pulsemixer
      ];
    };
  }
