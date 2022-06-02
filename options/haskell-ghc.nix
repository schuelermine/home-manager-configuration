{ config, pkgs, lib, ... }:
with lib // import ../lib2.nix lib;
let
  cfg = config.programs.haskell.ghc;
  pkgsConfigurable = cfg.package ? withPackages;
in {
  options.programs.haskell.ghc = {
    enable = mkEnableOption
      "the Glorious Glasgow Haskell Compilation System (compiler)" // {
        default = true;
      };
    package = mkPackageOption "GHC" {
      default = [ "ghc" ];
      example = "pkgs.haskell.packages.ghc921.ghc";
    };
    packages = mkOption {
      type = types.functionTo (types.listOf types.package);
      description = "The Haskell packages to install for GHC";
      default = hkgs: [ ];
      defaultText = literalExpression "hkgs: [ ]";
      example = literalExpression "hkgs: [ hkgs.primes ]";
    };
  };
  config = {
    home.packages = mkIf cfg.enable [
      (if pkgsConfigurable then
        cfg.package.withPackages cfg.packages
      else
        cfg.package)
    ];
    warnings = mkIf (cfg.enable && !pkgsConfigurable) [''
      You have provided a package as programs.haskell.ghc.package that doesn't have the withPackages utility function.
      This disables specifying packages via programs.haskell.ghc.packages.
    ''];
  };
}
