{ config, pkgs, lib, ... }:
with builtins // lib;
let cfg = config.programs.python.pip;
in {
  options.programs.python.pip = {
    enable = mkEnableOption "pip";
    package = mkPackageOption config.programs.python.pythonPackages "pip" { };
  };
  config.programs.python.packages = mkIf cfg.enable (_: [ cfg.package ]);
}
