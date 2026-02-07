{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.suites.fonts;
in
  {
    options.custom.home.suites.fonts = {
      enable = mkEnableOption "fonts suite";
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        freefont_ttf
        takao
        corefonts
        vista-fonts
        hack-font
      ];
      fonts.fontconfig = {
        enable = true;
        # defaultFonts = {
        #   monospace = [ "Hack" ];
        # };
        defaultFonts = {
          serif = [ "Noto Serif" "Noto Serif CJK JP" ];
          sansSerif = [ "Noto Sans" "Noto Sans CJK JP" ];
          monospace = [ "Noto Sans Mono" "Noto Sans Mono CJK JP" ];
        };
      };
    };
  }
