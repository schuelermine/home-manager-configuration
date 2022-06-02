{ config, pkgs, lib, ... }:
with lib;
let cfg = config.programs.nano;
in {
  options.programs.nano = {
    enable = mkEnableOption "nano";
    package = mkPackageOption "nano" { };
    config = mkOption {
      type = lib.types.lines;
      description = ''
        The nano configuration.
        This will be written to <path>~/.nanorc</path>
      '';
      default = "";
      example = ''"set atblanks"'';
    };
  };
  config.home = mkIf cfg.enable {
    packages = [ cfg.package ];
    files.".nanorc".text = cfg.config;
    sessionVariables."EDITOR" = "${cfg.package}";
  };
}
