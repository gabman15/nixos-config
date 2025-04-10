{ lib, ... }:

with lib; {
  options.custom.home.opts.stylix = mkOption {
    type = types.bool;
    default = false;
  };
}
