{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.programs.rust;
in {
  options.programs.rust.exposeRustSrcLocation = mkOption {
    type = types.nullOr types.path;
    description = ''
      Expose the rust library source code via the <envar>RUST_SRC_PATH</envar> variable.
      If set to null, the variable remains unset.
    '';
    default = null;
    defaultText = literalExpression "null";
    example = literalExpression
      ''"''${config.programs.rust.toolchainPackages.rustPlatform.rustLibSrc}"'';
  };
}
