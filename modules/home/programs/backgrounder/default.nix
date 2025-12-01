{ inputs, pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.backgrounder;
in
  {
    options.custom.home.programs.backgrounder = {
      enable = mkEnableOption "backgrounder script";
    };

    config = mkIf cfg.enable {
      age.secrets.backgrounder-config.file = ../../../../secrets/backgrounder-config.age;
      home.packages = [
        (pkgs.writeShellScriptBin "backgrounder" ''
        ${inputs.gabe-backgrounder.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/gabe-backgrounder -c ${config.age.secrets.backgrounder-config.path}
        '')
      ];
      systemd.user.timers.backgrounder = {
        Install = {
          WantedBy = [ "timers.target" ];
        };
        Timer = {
          OnCalendar = "*-*-* *:0,15,30,45:00";
          Unit = "backgrounder.service";
        };
      };
      systemd.user.services.backgrounder = {
        Service = {
          ExecStart = ''
            ${inputs.gabe-backgrounder.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/gabe-backgrounder -c ${config.age.secrets.backgrounder-config.path}
          '';
        };
      };
    };
  }
