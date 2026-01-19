{ inputs, pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.winclip;
in
  {
    options.custom.home.programs.winclip = {
      enable = mkEnableOption "wsl clipboard synchronizer";
    };

    config = let
      powershell = "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe";
    in mkIf cfg.enable {
      home.packages = [
        (pkgs.writeShellScriptBin "winclip-get" ''
          ${powershell} -noprofile -command Get-Clipboard| ${pkgs.wl-clipboard}/bin/wl-copy
        '')
        (pkgs.writeShellScriptBin "winclip-send" ''
          ${pkgs.wl-clipboard}/bin/wl-paste | ${powershell} -noprofile -command "chcp 65001 >\$null; clip.exe"
        '')
      ];
    };
  }
