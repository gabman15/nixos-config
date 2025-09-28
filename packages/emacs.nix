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
  extraEmacsPackages = epkgs: with epkgs; [
    my-config
  ];
}
