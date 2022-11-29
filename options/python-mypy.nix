{ config, pkgs, lib, ... }:
with builtins // lib;
let cfg = config.programs.python.mypy;
in {
  options.programs.python.mypy = {
    enable = mkEnableOption "mypy";
    package = mkPackageOption pkgs "mypy" { };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
