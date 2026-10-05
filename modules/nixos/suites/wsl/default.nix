{ inputs, lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.suites.wsl;
in
  {
    options.custom.nixos.suites.wsl = {
      enable = mkEnableOption "nixos wsl settings";
    };

    config = mkIf cfg.enable {
      wsl = {
        enable = true;
        defaultUser = config.custom.opts.username;
        wslConf = {
          network.generateHosts = false;
          network.generateResolvConf = false;
          interop.appendWindowsPath = false;
        };
      };
    };
  }
