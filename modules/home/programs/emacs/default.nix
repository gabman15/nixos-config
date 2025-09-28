{ pkgs, lib, config, ... }:

with lib; let
  cfg = config.custom.home.programs.emacs;
in
  {
    options.custom.home.programs.emacs = {
      enable = mkEnableOption "emacs text editor";
    };

    config = mkIf cfg.enable {
      home.file.".emacs.d" = {
        source = ./.emacs.d;
        recursive=true;
      };

      home.packages = with pkgs; [
        basedpyright
        nodePackages.vscode-json-languageserver
        emacs-all-the-icons-fonts
      ];

      programs.emacs.enable = true;
      programs.emacs.extraPackages = epkgs: [
        epkgs.nix-mode
        epkgs.flycheck
        epkgs.json-mode
        epkgs.python-mode
        epkgs.autothemer
        epkgs.lsp-mode
        epkgs.lsp-pyright
        epkgs.all-the-icons-dired
        epkgs.all-the-icons
      ];
    };
  }
