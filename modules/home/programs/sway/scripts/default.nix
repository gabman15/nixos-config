
pkgs: config:

rec {
  screenshot = (import ./screenshot.nix) pkgs config;
  translate = (import ./translate.nix) pkgs config;
  translate-screenshot = (import ./translate-screenshot.nix) pkgs config screenshot translate;
  winclip-send = (import ./winclip-send.nix) pkgs;
  winclip-get = (import ./winclip-get.nix) pkgs;
}
