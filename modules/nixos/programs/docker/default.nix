{ lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.programs.docker;
in
  {
    options.custom.nixos.programs.docker = {
      enable = mkEnableOption "docker virtualization";
    };

    config = mkIf cfg.enable {
      users.users.lord_gabem.extraGroups = [ "docker" ];
      virtualisation.docker.enable = true;
    };
  }
