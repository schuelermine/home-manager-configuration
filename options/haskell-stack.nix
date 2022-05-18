{ config, pkgs, lib, ... }:
with lib // import ../lib.nix lib;
let
  mkPackageOption' = mkPackageOption pkgs;
  cfg = config.programs.haskell.stack;
in {
  options.programs.haskell.stack = {
    enable = mkEnableOption "the Haskell Tool Stack";
    package = mkPackageOption' "Stack" { default = "stack"; };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
