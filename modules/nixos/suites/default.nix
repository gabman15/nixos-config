{ lib, ... }:

with lib; {
  imports = [
    ./graphical
    ./nvidia
  ];
}
