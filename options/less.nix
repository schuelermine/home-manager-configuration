{ config, pkgs, lib, ... }:
with lib;
let cfg = config.programs.less;
in {
  options.programs.less = {
    enable = mkEnableOption "the less pager";
    package = mkPackageOption "less" { };
    options = mkOption {
      type = types.listOf types.str;
      description = ''
        The options passed to less. This sets the <code>$LESS</code> environment variable.
      '';
      default = [ ];
      example = ''[ "-R" ]'';
    };
  };
  config.home = mkIf cfg.enable {
    packages = [ cfg.package ];
    sessionVariables = {
      "LESS" = builtins.concatStringsSep " " cfg.options;
      "PAGER" = "${cfg.package}";
    };
  };
}
