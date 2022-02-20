{ config, pkgs, lib, ... }:
let cfg = config.gnome.cursorTheme;
in with lib; {
  options.gnome.cursorTheme = {
    package = mkOption {
      type = types.nullOr types.package;
      default = null;
      defaultText = literalExpression "null";
      example = literalExpression "pkgs.yaru-theme";
      description = ''
        Package that provides the cursor theme.
        If not declared, it's assumed an already installed package provides it.
      '';
    };
    name = mkOption {
      type = types.str;
      default = "Adwaita";
      defaultText = literalExpression ''""'';
      example = literalExpression ''"Yaru"'';
      description = "Name of the custom theme.";
    };
  };
  config = {
    dconf.settings."org.gnome.desktop.interface".cursor-theme = cfg.name;
    home.packages = optional (cfg.package != null) cfg.package;
  };
}
