{ config, lib, modulesPath, ... }:

with lib; let
  cfg = config.custom.nixos.hardware.gigabyte-b650;
in
  {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    
    options.custom.nixos.hardware.gigabyte-b650 = {
      enable = mkEnableOption "gigabyte b650 hardware config";
    };
    
    config = mkIf cfg.enable {
      boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sr_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" =
        { device = "/dev/disk/by-label/NIXROOT";
          fsType = "btrfs";
          options = [ "subvol=@root" "noatime" "compress=lzo" "space_cache=v2" "subvolid=256" ];
        };

      fileSystems."/home" =
        { device = "/dev/disk/by-label/NIXROOT";
          fsType = "btrfs";
          options = [ "subvol=@home" "noatime" "compress=lzo" "space_cache=v2" "subvolid=257" ];
        };

      fileSystems."/boot/efi" =
        { device = "/dev/disk/by-label/NIXBOOT";
          fsType = "vfat";
          options = [ "fmask=0077" "dmask=0077" ];
        };

      fileSystems."/games" =
        { device = "/dev/disk/by-uuid/a7122656-609b-4d3b-91f9-5a78be9c60d3";
          fsType = "btrfs";
          options = [ "subvol=@games" "noatime" "compress=lzo" "space_cache=v2" "subvolid=257" ];
        };

      swapDevices = [ ];

      networking.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  }
