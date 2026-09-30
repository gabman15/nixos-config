{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.programs.tailscale;
in
  {
    options.custom.nixos.programs.tailscale = {
      enable = mkEnableOption "tailscale vpn";
    };
    
    config = mkIf cfg.enable {
      services.tailscale.enable = true;
      systemd.services.tailscale-online = {
        description = "Wait for Tailscale interface to be bindable";
        after = ["tailscaled.service"];
        requires = ["tailscaled.service"];
        wantedBy = ["multi-user.target"];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${pkgs.tailscale}/bin/tailscale wait --timeout=120s";
        };
      };
    };
  }
