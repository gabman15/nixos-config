{ lib, ... }:

with lib; {
  imports = [
    ./sway
    ./backgrounder
    ./kitty
    ./bash
    ./mpv
    ./waybar
    ./direnv
    ./gnupg
    ./rofi
    ./albumart
    ./rmpc
    ./emacs
    ./mpd
  ];
}
