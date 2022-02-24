{ config, pkgs, lib, ... }:
with lib; {
  options.home = {
    editor = mkOption { type = types.oneOf; };
    visualEditor = mkOption { };
  };
}
