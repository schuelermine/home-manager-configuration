{ config, pkgs, lib, ... }:
with lib;
let
  mkPackageOption' = pkgs: name:
    { default ? [ name ], example ? null }:
    let default' = if !isList default then [ default ] else default;
    in mkOption {
      type = types.package;
      description = "The ${name} package to use.";
      default = attrByPath default'
        (throw "${concatStringsSep "." default'} cannot be found in pkgs") pkgs;
      defaultText = literalExpression ("pkgs." + concatStringsSep "." default');
      ${if example != null then "example" else null} = literalExpression
        (if isList example then
          "pkgs." + concatStringsSep "." example
        else
          example);
    };
  mkPackageOption = mkPackageOption' pkgs;
  ifEnabled = pkg: optional pkg.enable pkg.package;
  onlyEnabled = pkgs: builtins.concatLists (map ifEnabled pkgs);
  cfg = config.programs.haskell;
in {
  options.programs.haskell = {
    cabal = {
      enable = mkEnableOption "the Haskell Cabal (build system)";
      package = mkPackageOption "Cabal" { default = [ "cabal-install" ]; };
    };
    ghc = {
      enable = mkEnableOption
        "the Glorious Glasgow Haskell Compilation System (compiler)" // {
          default = true;
        };
      package = mkPackageOption "GHC" {
        default = [ "ghc" ];
        example = "pkgs.haskell.packages.ghc921.ghc";
      };
    };
    stack = {
      enable = mkEnableOption "the Haskell Tool Stack";
      package = mkPackageOption "Stack" { default = "stack"; };
    };
  };
  config.home.packages = onlyEnabled (with cfg; [ cabal ghc stack ]);
}
