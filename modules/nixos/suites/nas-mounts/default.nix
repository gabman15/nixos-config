{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.suites.nas-mounts;
in
  {
    options.custom.nixos.suites.nas-mounts = {
      enable = mkEnableOption "network mount configurations for personal machines";
      mounts = mkOption {
        type = with types; listOf (attrsOf str);
        description = "nfs mount configs";
      };
    };
    
    config = mkIf cfg.enable {
      boot.supportedFilesystems = [ "nfs" ];
      systemd.mounts = let
        common-opts = {
          type = "nfs";
          mountConfig = {
            Options = "noatime,noauto";
          };
        };
      in map (mount-conf: common-opts // {
        what = mount-conf.what;
        where = mount-conf.where;
      }) cfg.mounts;

      systemd.automounts = let
        common-opts = {

          wantedBy = [ "multi-user.target" ];
        };
        tailscale-opts = if config.custom.nixos.programs.tailscale.enable
                         then
                           {
                             after = [ "tailscale-online.service" ];
                             requires = [ "tailscale-online.service" ];
                           }
                         else
                           {};
      in map (mount-conf: common-opts // tailscale-opts // {
        where = mount-conf.where;
      }) cfg.mounts;
    };
  }
