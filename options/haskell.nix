{ config, pkgs, lib, ... }:
with builtins // lib;
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
