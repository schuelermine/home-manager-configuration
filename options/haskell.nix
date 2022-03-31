{ config, pkgs, lib, ... }:
with lib // import ../alib.nix lib;
let mkPackageOption' = mkPackageOption pkgs;
in {
  options.programs.haskell = {
    cabal = {
      enable = mkEnableOption "the Haskell Cabal (build system)";
      package = mkPackageOption' "Cabal" { default = [ "cabal-install" ]; };
    };
    ghc = {
      enable = mkEnableOption
        "the Glorious Glasgow Haskell Compilation System (compiler)" // {
          default = true;
        };
      package = mkPackageOption' "GHC" {
        default = [ "ghc" ];
        example = "pkgs.haskell.packages.ghc921.ghc";
      };
      packages = mkOption {
        type = types.functionTo (types.listOf types.package);
        description = "Haskell packages";
        default = hkgs: [ ];
        defaultText = literalExpression "hkgs: [ ]";
        example = literalExpression "hkgs: [ hkgs.primes ]";
      };
    };
    stack = {
      enable = mkEnableOption "the Haskell Tool Stack";
      package = mkPackageOption' "Stack" { default = "stack"; };
    };
  };
  config = let cfg = config.programs.haskell;
  in {
    home.packages = optional cfg.cabal.enable cfg.cabal.package
      ++ optional cfg.ghc.enable (if cfg.ghc.package ? withPackages then
        cfg.ghc.package.withPackages cfg.ghc.packages
      else
        cfg.ghc.package) ++ optional cfg.stack.enable cfg.stack.package;
    warnings = if !cfg.ghc.package ? withPackages then [''
      You have provided a package as programs.haskell.ghc.package that doesn't have the withPackages utility function.
      This disables specifying packages via programs.haskell.ghc.packages.
    ''] else
      [ ];
  };
}
