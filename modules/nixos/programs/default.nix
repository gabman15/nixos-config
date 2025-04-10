{ lib, ... }:

with lib; {
  imports = [
    ./ssh
    ./docker
  ];
}
