{ lib, ... }:

with lib; {
  imports = [
    ./framework-13
    ./dell-inspiron-15-7000
    ./gigabyte-b650
  ];
}
