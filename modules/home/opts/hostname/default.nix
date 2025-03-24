{ lib, ... }:

with lib; {
  options.custom.home.opts.hostname = mkOption {
    type = with types; str;
  };
}
