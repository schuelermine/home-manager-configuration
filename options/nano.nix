{ config, pkgs, lib, ... }:
with lib;
let cfg = config.programs.nano;
in {
  options.programs.nano = {
    enable = mkEnableOption "nano";
    package = mkPackageOption pkgs "nano" { };
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
    file.".nanorc".text = cfg.config;
    editor = "${cfg.package}/bin/nano";
  };
}
