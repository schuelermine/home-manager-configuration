{ config, pkgs, lib, ... }:
with builtins // lib;
let
  cfg = config.programs.haskell.ghc;
  pkgsConfigurable = cfg.package ? withPackages;
in {
  options.programs.haskell.ghc = {
    enable = mkEnableOption
      "the Glorious Glasgow Haskell Compilation System (compiler)";
    package = mkPackageOption config.programs.haskell.haskellPackages "GHC" {
      default = [ "ghc" ];
    };
    packages = mkOption {
      type = types.functionTo (types.listOf types.package);
      apply = x: if !builtins.isFunction x then _: x else x;
      description = "The Haskell packages to install for GHC";
      default = hkgs: [ ];
      defaultText = literalExpression "hkgs: [ ]";
      example = literalExpression "hkgs: [ hkgs.primes ]";
    };
    ghciConfig = mkOption {
      type = types.nullOr types.lines;
      description = "The contents of the <code>.ghci</code> file";
      default = null;
      defaultText = literalExpression "null";
      example = literalExpression ''
        :set +s
      '';
    };
  };
  config = mkIf cfg.enable {
    home.packages = [
      (if pkgsConfigurable then
        cfg.package.withPackages cfg.packages
      else
        cfg.package)
    ];
    xdg.configFile.".ghci" =
      mkIf (cfg.ghciConfig != null) { text = cfg.ghciConfig; };
    warnings = mkIf (!pkgsConfigurable) [''
      You have provided a package as programs.haskell.ghc.package that doesn't have the withPackages utility function.
      This disables specifying packages via programs.haskell.ghc.packages.
    ''];
  };
}
