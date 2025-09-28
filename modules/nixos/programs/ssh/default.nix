{ lib, config, ... }

  let
    cfg = config.nixos.programs.ssh
  in
    {
      options = opt {
        enable = mkEnableOption "ssh server";
      };

      config = lib.mkIf cfg.enable {
        services.openssh.enable = true;
      }
    };
