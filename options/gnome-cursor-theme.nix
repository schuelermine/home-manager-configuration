{ config, pkgs, lib, ... }:
with lib; {
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
      type = types.nullOr types.str;
      default = null;
      defaultText = literalExpression ''""'';
      example = literalExpression ''"Yaru"'';
      description = "Name of the custom theme.";
    };
  };
  config = let cfg = config.gnome.cursorTheme;
  in mkIf (cfg.name != null) {
    dconf.settings."org.gnome.desktop.interface".cursor-theme = cfg.name;
  };
}
