{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.programs.rust.rustup;
in {
  options.programs.rust.rustup = {
    enable = mkEnableOption "rustup, the Rust toolchain installer";
    package = mkPackageOption pkgs "rustup" { };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
