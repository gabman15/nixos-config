{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.discord;
  krisp-patcher-python = pkgs.writers.writePython3Bin "krisp-patcher-python" {
    libraries = with pkgs.python3Packages; [ capstone pyelftools ];
    flakeIgnore = [
      "E501" # line too long (82 > 79 characters)
      "F403" # ‘from module import *’ used; unable to detect undefined names
      "F405" # name may be undefined, or defined from star imports: module
    ];
  } (builtins.readFile ./krisp-patcher.py);
  krisp-patcher = pkgs.writeShellScriptBin "krisp-patcher" ''
    ${krisp-patcher-python}/bin/krisp-patcher-python ~/.config/discord/0.*/modules/discord_krisp/discord_krisp.node
  '';
in
  {
    options.custom.home.programs.discord = {
      enable = mkEnableOption "discord";
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        discord
        krisp-patcher
      ];
    };
  }
