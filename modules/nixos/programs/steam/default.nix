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
        extraPackages = let
          ld_gamescope = pkgs.writeShellScriptBin "ld_gamescope" ''
    exec \
      env \
        -u LD_PRELOAD LD_BIND_NOW=1 \
        ${pkgs.gamescope}/bin/gamescope \
        -f \
        -w 2560 -W 2560 -h 1440 -H 1440 \
        --force-grab-cursor \
        -- \
        env \
          LD_PRELOAD="$LD_PRELOAD" \
          "$@"
  '';
        in
          with pkgs; [
            ld_gamescope
            gamescope
            mangohud
            gamemode
          ];
        extest.enable = true;
        localNetworkGameTransfers.openFirewall = true;
        remotePlay.openFirewall = true;
      };
    };
  }
