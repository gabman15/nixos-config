{ pkgs, lib, ... }:

let
  myEmacsConfig = ./emacs;
  emacsConfigs = lib.mapAttrsToList (fname: _: "${myEmacsConfig}/${fname}") (
    lib.filterAttrs (_: type: type == "regular") (builtins.readDir "${myEmacsConfig}/")
  );
  
in
pkgs.emacsWithPackagesFromUsePackage {
  package = pkgs.emacs-nox;
  config = lib.concatMapStringsSep "\n" builtins.readFile emacsConfigs;
  
  # defaultInitFile = true;
  # alwaysEnsure = true;
  override = epkgs: epkgs // {
    my-config = (pkgs.runCommand "default.el" {} ''
              mkdir -p $out/share/emacs/site-lisp
              cp -r ${myEmacsConfig}/* $out/share/emacs/site-lisp/
            '');
  };
  extraEmacsPackages = epkgs: [
    epkgs.llama
    epkgs.f
    epkgs.s
    epkgs.ht
    epkgs.lv
    epkgs.spinner
    # epkgs.use-package
    epkgs.my-config
    # epkgs.magit
    # epkgs.nix-mode
    # epkgs.flycheck
    # epkgs.json-mode
    # epkgs.python-mode
    # epkgs.autothemer
    # epkgs.lsp-mode
    # epkgs.lsp-pyright
    # epkgs.all-the-icons-dired
    # epkgs.all-the-icons
    pkgs.basedpyright
    pkgs.nodePackages.vscode-json-languageserver
    pkgs.emacs-all-the-icons-fonts
    pkgs.nixd
    pkgs.hack-font
  ];
}
