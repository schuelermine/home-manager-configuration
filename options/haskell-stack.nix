{ config, pkgs, lib, ... }:
with lib // import ../alib.nix lib;
let
  mkPackageFunction' = mkPackageFunction pkgs;
  cfg = config.programs.haskell.stack;
in {
  stack = {
    enable = mkEnableOption "the Haskell Tool Stack";
    package = mkPackageOption' "Stack" { default = "stack"; };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
