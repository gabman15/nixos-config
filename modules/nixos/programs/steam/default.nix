{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.programs.steam;
in
  {
    options.custom.nixos.programs.steam = {
      enable = mkEnableOption "steam";
    };

    
    config = mkIf cfg.enable {
      programs.steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
        extraPackages = with pkgs; [
          gamescope
          mangohud
          gamemode
        ];
        extest.enable = true;
        localNetworkGameTransfers.openFirewall = true;
      };
    };
  }
