{ config, pkgs, lib, ... }:
with builtins // lib;
let cfg = config.programs.haskell.language-server;
in {
  options.programs.haskell.language-server = {
    enable = mkEnableOption "the Haskell Language Server";
    package = mkPackageOption config.programs.haskell.haskellPackages "HLS" {
      default = [ "haskell-language-server" ];
    };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
