{ lib, ... }:

with lib; {
  imports = [
    ./mpd
    ./dev
    ./graphical
  ];
}
