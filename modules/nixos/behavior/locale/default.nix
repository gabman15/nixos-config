{ lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.behavior.locale;
in
  {
    options.custom.nixos.behavior.locale = {
      enable = mkEnableOption "locale configuration";
    };
    
    config = mkIf cfg.enable {
      i18n = {
        defaultLocale = "en_US.UTF-8";
        supportedLocales = [
          "en_US.UTF-8/UTF-8"
          "ja_JP.UTF-8/UTF-8"
        ];
      };
    };
  }
