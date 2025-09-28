pkgs: let
  lib = pkgs.lib;
  myEmacsConfig = ./emacs;
  emacsConfigs = lib.mapAttrsToList (fname: _: "${myEmacsConfig}/${fname}") (
    lib.filterAttrs (_: type: type == "regular") (builtins.readDir "${myEmacsConfig}/")
  );
  emacsPkg = pkgs.emacsWithPackagesFromUsePackage {
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
      epkgs.my-config
      pkgs.basedpyright
      pkgs.nodePackages.vscode-json-languageserver
      pkgs.nixd
      pkgs.intelephense
      pkgs.emacs-all-the-icons-fonts
      pkgs.hack-font
    ];
  };
in
pkgs.symlinkJoin {
  name = "emacs";
  paths = [ emacsPkg ];
  buildInputs = with pkgs; [ makeWrapper ];
  postBuild = ''
    mkdir $out/emptyConfig
    wrapProgram $out/bin/emacs --add-flags "--init-directory=/tmp/emacsConfig"
  '';
}
