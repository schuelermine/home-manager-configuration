{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.programs.haskell.ghcup;
in {
  options.programs.haskell.ghcup = {
    enable = mkEnableOption "GHCup, a Haskell installer";
    package = mkPackageOption pkgs "GHCup" { default = [ "ghcup" ]; };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
