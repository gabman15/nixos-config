{ lib, config, ... }:

with lib; let
  cfg = config.custom.nixos.programs.wireshark;
in
  {
    options.custom.nixos.programs.wireshark = {
      enable = mkEnableOption "wireshark network sniffer";
    };

    config = mkIf cfg.enable {
      users.users.${config.custom.opts.username}.extraGroups = [ "wireshark" ];
      programs.wireshark = {
        enable = true;
        dumpcap.enable = true;
      };
    };
  }
