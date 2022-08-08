{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.programs.rust.rust-analyzer;
in {
  options.programs.rust.rust-analyzer = {
    enable = mkEnableOption "rust-analyzer, a Rust language server";
    package = mkPackageOption pkgs "rust-analyzer" { };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
