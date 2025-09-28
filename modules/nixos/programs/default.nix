{ lib, ... }:

with lib; {
  imports = [
    ./gnupg
    ./ssh
  ];
}
