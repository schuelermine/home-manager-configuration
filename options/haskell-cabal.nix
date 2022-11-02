{ config, pkgs, lib, ... }:
with builtins // lib;
let cfg = config.programs.haskell.cabal;
in {
  options.programs.haskell.cabal = {
    enable = mkEnableOption "the Haskell Cabal (build system)";
    package = mkPackageOption pkgs "Cabal" { default = [ "cabal-install" ]; };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
