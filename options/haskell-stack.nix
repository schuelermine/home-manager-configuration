{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.programs.haskell.stack;
in {
  options.programs.haskell.stack = {
    enable = mkEnableOption "the Haskell Tool Stack";
    package = mkPackageOption pkgs "Stack" { default = [ "stack" ]; };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
