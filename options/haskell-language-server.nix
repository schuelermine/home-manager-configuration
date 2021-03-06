{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
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
