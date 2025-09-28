{ config, lib, modulesPath, ... }:

with lib; let
  cfg = config.custom.nixos.hardware.dell-inspiron-15-7000;
in
  {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    options.custom.nixos.hardware.dell-inspiron-15-7000 = {
      enable = mkEnableOption "dell inspiron 15 7000 hardware config";
    };

    config = mkIf cfg.enable {
      boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "sd_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      networking.useDHCP = lib.mkDefault true;
      # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      disko.devices = {
        disk = {
          my-disk = {
            device = "/dev/disk/by-id/ata-TOSHIBA_MQ02ABD100H_17AJT4R9T";
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  type = "EF00";
                  size = "500M";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot/efi";
                    mountOptions = [ "umask=0077" ];
                  };
                };
                root = {
                  size = "100%";
                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };
              };
            };
          };
        };
      };
    };
  }
