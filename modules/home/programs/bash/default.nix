{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.bash;
in
  {
    options.custom.home.programs.bash = {
      enable = mkEnableOption "bash shell";
      sprite = mkOption {
        description = "Touhou sprite";
        type = with types; nullOr str;
        default = null;
      };
    };

    
    config = mkIf cfg.enable {
      programs.bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          ls = "ls -lha --color=auto";
          rb = "sudo nixos-rebuild switch";
        };
        
        bashrcExtra = let
          spriteCat = if cfg.sprite == null then "" else ''
            ${pkgs.coreutils}/bin/cat ${cfg.sprite}
          '';
        in
          ''
          PS1='[\[\033[1;36m\]\u@\h \[\033[33m\]\W\[\033[00m\]]\$ '
          ${spriteCat}
          export PF_COL1=6
          export PF_COL3=3
          export PF_INFO="title os host kernel uptime pkgs memory"
          ${pkgs.pfetch}/bin/pfetch
          '';
      };
    };
  }
