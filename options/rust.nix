{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.programs.rust;
in {
  options.programs.rust.toolchainPackages = mkOption {
    type = types.attrsOf types.package;
    description = "The Rust toolchain package set to use";
    default = pkgs.rust.packages.stable;
    defaultText = literalExpression "pkgs.rust.packages.stable";
    example = literalExpression "pkgs.rust.packages.prebuilt";
  };
}
