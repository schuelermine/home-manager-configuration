{ config, pkgs, lib, lib1, lib2, ... }:
with builtins // lib // lib1 // lib2;
let cfg = config.programs.haskell.stack;
in {
  options.programs.haskell.stack = {
    enable = mkEnableOption "the Haskell Tool Stack";
    package = mkPackageOption config.programs.haskell.haskellPackages "Stack" {
      default = [ "stack" ];
    };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
