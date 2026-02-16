{ config, lib, modulesPath, ... }:

with lib; let
  cfg = config.custom.nixos.hardware.dell-optiplex-7060-micro;
in
  {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    options.custom.nixos.hardware.dell-optiplex-7060-micro = {
      enable = mkEnableOption "dell optiplex 7060 micro hardware config";
    };

    config = mkIf cfg.enable {
      boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];
      networking.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      disko.devices = {
        disk = {
          my-disk = {
            device = "/dev/disk/by-id/nvme-KBG40ZNS256G_NVMe_TOSHIBA_256GB_89TPC24ZPQEN";
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  label = "NIXBOOT";
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
                  label = "NIXROOT";
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
