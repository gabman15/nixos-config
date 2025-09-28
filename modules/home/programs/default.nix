{ lib, ... }:

with lib; {
  imports = [
    ./sway
    ./backgrounder
    ./kitty
    ./bash
    ./mpv
    ./waybar
  ];
}
