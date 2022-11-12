{ config, pkgs, lib, ... }:
with builtins // lib;
let
  cfg = config.programs.haskell;
  ghcVersionName = config.programs.haskell.ghcVersionName;
in {
  options.programs.haskell = {
    haskellPackages = mkOption {
      type = with types; attrsOf package;
      description = "The Haskell package set to use.";
      default = if ghcVersionName != null then
        pkgs.haskell.packages."ghc${ghcVersionName}"
      else
        pkgs.haskellPackages;
      defaultText = literalExpression "pkgs.haskellPackages";
      example = literalExpression "pkgs.haskell.packages.ghc923";
    };
    ghcVersionName = mkOption {
      type = with types; nullOr str;
      apply = opt:
        if opt != null then replaceStrings [ "." ] [ "" ] opt else null;
      description = ''
        The GHC version to use.
        Setting this value automatically sets <option>programs.haskell.haskellPackages</option>.
      '';
      default = null;
      defaultText = literalExpression "null";
      example = literalExpression ''"942"'';
    };
  };
}
