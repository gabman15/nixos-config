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
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        freefont_ttf
        corefonts
        vistafonts
        hack-font
        pulsemixer
      ];
      fonts.fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [ "Hack" ];
        };
      };
    };
  }
