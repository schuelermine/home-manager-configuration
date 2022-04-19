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
    hls = {
      enable = mkEnableOption "the Haskell Language Server";
      package = mkPackageOption' "HLS" { default = "haskell-language-server"; };
    };
  };
  config = mkMerge [
    ({ config, ... }:
      mkIf config.programs.haskell.ghc.enable
      (if config.programs.haskell.ghc.package ? withPackages then {
        config.home.packages = [
          (config.programs.haskell.ghc.package.withPackages
            config.programs.haskell.packages)
        ];
      } else {
        config.home.packages = [ config.programs.haskell.ghc.package ];
        warnings = [''
          You have provided a package as programs.haskell.ghc.package that doesn't have the withPackages utility function.
          This disables specifying packages via programs.haskell.ghc.packages.
        ''];
      }))
    ({ config, ... }:
      mkIf config.programs.haskell.cabal.enable {
        config.home.packages = [ config.programs.haskell.cabal.package ];
      })
    ({ config, ... }:
      mkIf config.programs.haskell.stack.enable {
        config.home.packages = [ config.programs.haskell.stack.package ];
      })
    ({ config, ... }:
      mkIf config.programs.haskell.hls.enable {
        config.home.packages = [ config.programs.haskell.hls.package ];
      })
  ];
}
