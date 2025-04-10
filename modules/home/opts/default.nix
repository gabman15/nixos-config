{ lib, ... }:

with lib; {
  imports = [
    ./hostname
    ./stylix
  ];
}
