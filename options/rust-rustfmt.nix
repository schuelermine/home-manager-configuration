{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let
  cfg = config.programs.rust.rustfmt;
  tomlFormat = pkgs.formats.toml { };
in {
  options.programs.rust.rustfmt = {
    enable = mkEnableOption "rustfmt, the Rust formatter";
    package =
      mkPackageOption config.programs.rust.toolchainPackages "rustfmt" { };
    settings = mkOption {
      type = types.nullOr tomlFormat.type;
      description = ''
        Configuration written to <code>$XDG_CONFIG_HOME/rustfmt/rustfmt.toml</code>.
        If set to <code>null</code>, no file will be generated.
      '';
      default = null;
      defaultText = literalExpression "null";
      example = literalExpression ''
        {
          indent_style = "Block";
          reorder_imports = false;
        }
      '';
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile = mkIf (cfg.settings != null) {
      "rustfmt/rustfmt.toml" =
        tomlFormat.generate "rustfmt-config" cfg.settings;
    };
  };
}
