{ config, lib, modulesPath, ... }:

with lib; let
  cfg = config.custom.nixos.hardware.framework-13;
in
  {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    
    options.custom.nixos.hardware.framework-13 = {
      enable = mkEnableOption "framework 13 hardware config";
    };
    
    config = mkIf cfg.enable {
      boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" =
        { device = "/dev/mapper/root";
          # device = "/dev/disk/by-uuid/806b0a0a-4619-452b-b22d-24574a0ebee7";
          fsType = "btrfs";
          options = [ "subvol=@root" ];
        };

      boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/53ef6109-2433-4a56-af15-30e11e387671";

      fileSystems."/home" =
        { device = "/dev/mapper/root";
          fsType = "btrfs";
          options = [ "subvol=@home" ];
        };

      fileSystems."/toplevel" =
        { device = "/dev/mapper/root";
          fsType = "btrfs";
        };

      fileSystems."/boot/efi" =
        { device = "/dev/disk/by-uuid/B41B-717C";
          fsType = "vfat";
          options = [ "fmask=0077" "dmask=0077" ];
        };

      swapDevices = [ ];

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      networking.useDHCP = lib.mkDefault true;
      # networking.interfaces.wlp166s0.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  }
