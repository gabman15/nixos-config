{ lib, ... }:

with lib; {
  options.custom.opts.hostname = mkOption {
    type = with types; str;
  };
}
