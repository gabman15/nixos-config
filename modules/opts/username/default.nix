{ lib, ... }:

with lib; {
  options.custom.opts.username = mkOption {
    type = with types; str;
  };
}
