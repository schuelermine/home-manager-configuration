{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.programs.rust.clippy;
in {
  options.programs.rust.clippy = {
    enable = mkEnableOption "clippy, the Rust linter";
    package =
      mkPackageOption config.programs.rust.toolchainPackages "clippy" { };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
