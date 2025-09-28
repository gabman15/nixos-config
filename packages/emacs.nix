pkgs: profile: let
  getConfigs = (config: lib.mapAttrsToList (fname: _: "${config}/${fname}") (
    lib.filterAttrs (_: type: type == "regular") (builtins.readDir "${config}/")
  ));
  lib = pkgs.lib;
  baseConfig = ./emacs/basic;
  profileConfig = lib.path.append ./emacs profile;
  emacsConfigs = (getConfigs baseConfig) ++ (getConfigs profileConfig);
  emacsPkg = pkgs.emacsWithPackagesFromUsePackage {
    package = pkgs.emacs-nox;
    config = lib.concatMapStringsSep "\n" builtins.readFile emacsConfigs;
    # defaultInitFile = true;
    # alwaysEnsure = true;
    override = epkgs: epkgs // {
      my-config = (pkgs.runCommand "default.el" {} ''
                mkdir -p $out/share/emacs/site-lisp
                cp -r ${baseConfig}/* $out/share/emacs/site-lisp/
                cp -r ${profileConfig}/* $out/share/emacs/site-lisp/
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
      pkgs.vscode-langservers-extracted
      pkgs.nixd
      pkgs.intelephense
      pkgs.lemminx
      pkgs.ccls
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
