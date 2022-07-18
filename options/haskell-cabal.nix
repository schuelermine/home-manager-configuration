{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.programs.haskell.cabal;
in {
  options.programs.haskell.cabal = {
    enable = mkEnableOption "the Haskell Cabal (build system)";
    package = mkPackageOption pkgs "Cabal" { default = [ "cabal-install" ]; };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
