{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.programs.rust.rls;
in {
  options.programs.rust.rls = {
    enable = mkEnableOption "rls, the Rust language server";
    package = mkPackageOption config.programs.rust.toolchainPackages "rls" { };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
