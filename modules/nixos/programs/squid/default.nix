{ lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.programs.squid;
in
  {
    options.custom.nixos.programs.squid = {
      enable = mkEnableOption "squid proxy server";
    };

    config = mkIf cfg.enable {
      services.squid.enable = true;
      networking.proxy.default = "http://127.0.0.1:3128";
    };
  }
