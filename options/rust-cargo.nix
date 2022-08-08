{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let
  cfg = config.programs.rust.cargo;
  tomlFormat = pkgs.formats.toml { };
in {
  options.programs.rust.cargo = {
    enable = mkEnableOption "cargo, the Rust build system";
    package =
      mkPackageOption config.programs.rust.toolchainPackages "cargo" { };
    settings = mkOption {
      type = types.nullOr tomlFormat.type;
      description = ''
        Configuration written to <code>$CARGO_HOME/config.toml</code>.
        Defaults to <code>$HOME/.cargo/config.toml</code>.
        If set to <code>null</code>, no file will be generated.
      '';
      default = null;
      defaultText = literalExpression "null";
      example = literalExpression ''
        {
          cargo-new.vcs = "pijul";
        }
      '';
    };
    cargoHome = mkOption {
      type = types.nullOr types.str;
      description = ''
        The value of the <code>$CARGO_HOME</code> environment variable, relative to your home directory.
        If set to <code>null</code>, remains unset.
      '';
      default = null;
      defaultText = literalExpression "null";
    };
  };
  config.home = mkIf cfg.enable {
    packages = [ cfg.package ];
    file = mkIf (cfg.settings != null) {
      "${
        if cfg.cargoHome == null then ".cargo" else cfg.cargoHome
      }/config.toml".source = (tomlFormat.generate "cargo-config" cfg.settings);
    };
    sessionVariables = mkIf (cfg.cargoHome != null) {
      CARGO_HOME = "${config.home.homeDirectory}/${cfg.cargoHome}";
    };
  };
}
