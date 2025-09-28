{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.programs.gnupg;
in
  {
    options.custom.nixos.programs.gnupg = {
      enable = mkEnableOption "gnupg secret manager";
    };

    
    config = mkIf cfg.enable {
      programs.gnupg.agent = {
        enable = true;
        pinentryPackage = with pkgs; pinentry-curses;
        enableSSHSupport = true;
        settings = {
          default-cache-ttl = 86400;
          default-cache-ttl-ssh = 86400;
        };
      };
    };
  }
