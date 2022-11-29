{ config, pkgs, lib, ... }:
with builtins // lib;
let
  cfg = config.programs.haskell;
in {
  options.programs.haskell = {
    ghcVersionName = mkOption {
      type = with types; nullOr str;
      apply = opt:
        if opt != null
        then replaceStrings [ "." ] [ "" ] opt
        else null;
      description = ''
        The GHC version to use.
        Setting this value automatically sets <option>programs.haskell.haskellPackages</option>.
        The value is automatically stripped of spaces to match nixpkgs naming convention.
      '';
      default = null;
      defaultText = literalExpression "null";
      example = literalExpression ''"942"'';
    };
    haskellPackages = mkOption {
      type = with types; attrsOf package;
      description = "The Haskell package set to use.";
      default = if cfg.ghcVersionName != null then
        pkgs.haskell.packages."ghc${cfg.ghcVersionName}"
      else
        pkgs.haskellPackages;
      defaultText = literalExpression "pkgs.haskellPackages";
      example = literalExpression "pkgs.haskell.packages.ghc923";
    };
  };
}
