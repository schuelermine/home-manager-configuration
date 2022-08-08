{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.programs.rust.rust-src;
in {
  options.programs.rust.rust-src = {
    enable = mkEnableOption ''
      rust-src, a Rust language server.
      This only works when using a community rust overlay
    '';
    package =
      mkPackageOption config.programs.rust.toolchainPackages "rust-src" { };
  };
  config.home.packages = mkIf cfg.enable [ cfg.package ];
}
