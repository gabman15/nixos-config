{ inputs, config, ... }:

{
  custom = {
    themes.enable = true;
    nixos = {
      suites = {
        wsl.enable = true;
        work-mounts.enable = true;
      };
      programs = {
        tailscale.enable = true;
        squid.enable = true;
        docker.enable = true;
        wireshark.enable = true;
      };
      behavior.locale.enable = true;
    };
  };

  programs.nix-ld.enable = true;

  virtualisation.docker.daemon.settings = {
    "default-address-pools" = [
      {
        "base" = "192.168.0.1/16";
        "size" = 24;
      }
    ];
  };

  age.secrets.squid-work-conf.file = ../../../../secrets/squid-work-conf.age;

  # services.squid.extraConfig = "include ${config.age.secrets.squid-work-conf.path}";

  system.stateVersion = "24.11";
}
