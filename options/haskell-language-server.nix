{ config, pkgs, lib, ... }:
with lib // import ../lib2.nix lib;
let cfg = config.programs.haskell.language-server;
in {
  options.programs.haskell.language-server = {
    enable = mkEnableOption "the Haskell Language Server";
    package =
      mkPackageOption pkgs "HLS" { default = [ "haskell-language-server" ]; };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
