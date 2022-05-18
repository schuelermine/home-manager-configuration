{ config, pkgs, lib, ... }:
with lib // import ../lib.nix lib;
let
  mkPackageOption' = mkPackageOption pkgs;
  cfg = config.programs.haskell.language-server;
in {
  options.programs.haskell.language-server = {
    enable = mkEnableOption "the Haskell Language Server";
    package = mkPackageOption' "HLS" { default = "haskell-language-server"; };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
