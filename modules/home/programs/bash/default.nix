{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.bash;
in
  {
    options.custom.home.programs.bash = {
      enable = mkEnableOption "bash shell";
    };

    config = mkIf cfg.enable {
      programs.bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          ls = "ls -lha --color=auto";
          rb = "sudo nixos-rebuild switch";
        };
        bashrcExtra = ''
        PS1='[\[\033[1;36m\]\u@\h \[\033[33m\]\W\[\033[00m\]]\$ '
      '';
      };
    };
  }
