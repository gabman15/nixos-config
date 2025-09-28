{ inputs, pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.backgrounder;
in
  {
    options.custom.home.programs.backgrounder = {
      enable = mkEnableOption "backgrounder script";
    };

    config = mkIf cfg.enable {
      home.packages = [
        (pkgs.writeShellScriptBin "backgrounder" ''
        ${inputs.gabe-backgrounder.packages.${pkgs.system}.default}/bin/gabe-backgrounder -c ${config.age.secrets.backgrounder-config.path}
        '')
      ];
    };
  }
