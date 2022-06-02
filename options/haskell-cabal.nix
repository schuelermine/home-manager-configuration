{ config, pkgs, lib, ... }:
with lib // import ../lib2.nix lib;
let cfg = config.programs.haskell.cabal;
in {
  options.programs.haskell.cabal = {
    enable = mkEnableOption "the Haskell Cabal (build system)";
    package = mkPackageOption "Cabal" { default = [ "cabal-install" ]; };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
