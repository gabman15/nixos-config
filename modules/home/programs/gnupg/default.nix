{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.gnupg;
in
  {
    options.custom.home.programs.gnupg = {
      enable = mkEnableOption "gnupg secret manager";
    };

    
    config = mkIf cfg.enable {
      programs.gpg.enable = true;
      services.gpg-agent = {
        enable = true;
        pinentry.package = with pkgs; pinentry-gtk2;
        enableSshSupport = true;
        defaultCacheTtl = 86400;
        defaultCacheTtlSsh = 86400;
      };
    };
  }
