{ lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.programs.ssh;
in
  {
    options.custom.nixos.programs.ssh = {
      enable = mkEnableOption "ssh server";
    };
    
    config = mkIf cfg.enable {
      services.openssh.enable = true;
    };
  }
