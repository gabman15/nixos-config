{ pkgs, ... }:

let
  myEmacsConfig = ./emacs;
in
pkgs.emacsWithPackagesFromUsePackage {
  config = "${myEmacsConfig}/init.el";
  defaultInitFile = true;
  override = epkgs: epkgs // {
    my-config = (pkgs.runCommand "init.el" {} ''
              mkdir -p $out/share/emacs/site-lisp
              cp -r ${myEmacsConfig}/* $out/share/emacs/site-lisp/
            '');
  };
  extraEmacsPackages = epkgs: [
    epkgs.my-config
    epkgs.nix-mode
    epkgs.flycheck
    epkgs.json-mode
    epkgs.python-mode
    epkgs.autothemer
    epkgs.lsp-mode
    epkgs.lsp-pyright
    epkgs.all-the-icons-dired
    epkgs.all-the-icons
    pkgs.basedpyright
    pkgs.nodePackages.vscode-json-languageserver
    pkgs.emacs-all-the-icons-fonts
  ];
}
