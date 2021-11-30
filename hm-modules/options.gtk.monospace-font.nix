{ config, pkgs, lib, ... }:
let
  formatGtk2Option = n: v:
    let
      v' = if builtins.isBool v then
        (if v then "true" else "false")
      else if builtins.isString v then
        ''"${v}"''
      else
        toString v;
    in "${n} = ${v'}";
in {
  options.gtk.monospace-font = lib.mkOption {
    type = lib.types.nullOr lib.hm.types.fontType;
    default = null;
    example = {
      name = "JetBrains Mono";
      package = pkgs.jetbrains-mono;
      size = 11;
    };
  };
  config.home.packages = lib.optional (config.gtk.monospace-font != null)
    config.gtk.monospace-font.package;
  #  config.gtk.gtk2.
}
