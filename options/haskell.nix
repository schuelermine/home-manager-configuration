{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.programs.haskell;
in {
  options.programs.haskell.haskellPackages = mkOption {
    type = types.attrsOf types.package;
    description = "The Haskell package set to use";
    default = pkgs.haskellPackages;
    defaultText = literalExpression "pkgs.haskellPackages";
    example = literalExpression "pkgs.haskell.packages.ghc923";
  };
}
