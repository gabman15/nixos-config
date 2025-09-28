{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.kitty;
in
  {
    options.custom.home.programs.kitty = {
      enable = mkEnableOption "kitty terminal";
    };

    config = mkIf cfg.enable {
      enable = true;
      package = pkgs.kitty;

      font = {
        name = "Hack Regular";
        package = pkgs.hack-font;
        size = 12;
      };

      
    };
  }
