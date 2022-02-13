{ config, pkgs, lib, ... }:
with lib; {
  options.gnome.shellTheme = {
    enable = mkEnableOption "custom GNOME shell themes";
    package = mkOption {
      type = types.nullOr types.package;
      default = null;
      defaultText = "null";
      example = literalExpression "pkgs.yaru-theme";
      description = ''
        Package that provides the custom shell theme.
        If not declared, it's assumed an already installed package provides it.
      '';
    };
    name = mkOption {
      type = types.str;
      default = "";
      defaultText = ''""'';
      example = literalExpression ''"Yaru"'';
      description = "Name of the custom theme.";
    };
    userThemesPackage = mkPackageOption pkgs "user-themes extension" {
      default = [ "gnomeExtensions" "user-themes" ];
    };
  };
  config = let cfg = config.gnome.shellTheme;
  in {
    gnome.enabledExtensions = mkIf cfg.enable [ cfg.userThemesPackage ];
    dconf.settings."org/gnome/shell/extensions/user-theme".name = cfg.name;
    home.packages = optional (cfg.package != null) cfg.package;
  };
}
