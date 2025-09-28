{ lib, ... }:

with lib; {
  imports = [
    ./ssh
    ./docker
    ./vpn-namespace
  ];
}
