{ config, pkgs, lib, ... }:
with lib // import ../alib.nix lib;
let
  mkPackageOption' = mkPackageFunction pkgs;
  cfg = config.programs.haskell.cabal;
in {
  options.programs.haskell.cabal = {
    enable = mkEnableOption "the Haskell Cabal (build system)";
    package = mkPackageOption' "Cabal" { default = "cabal-install"; };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
