{ config, pkgs, lib, ... }:
with lib // import ../lib2.nix lib;
let cfg = config.programs.haskell.stack;
in {
  options.programs.haskell.stack = {
    enable = mkEnableOption "the Haskell Tool Stack";
    package = mkPackageOption pkgs "Stack" { default = [ "stack" ]; };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
