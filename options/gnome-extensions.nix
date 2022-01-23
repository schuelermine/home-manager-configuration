{ config, pkgs, lib, ... }:
with lib; {
  options.gnome = {
    enabledExtensions = mkOption {
      type = types.listOf types.package;
      default = [ ];
      defaultText = "[ ]";
      example = literalExpression "[ pkgs.gnomeExtensions.appindicator ]";
      description =
        "List of packages that provide extensions that are to be enabled.";
    };
    extraExtensions = mkOption {
      type = types.listOf types.package;
      default = [ ];
      defaultText = "[ ]";
      description = "Extra extension packages to install (but not enable).";
    };
  };
  config = {
    dconf.settings."org/gnome/shell" = {
      enabled-extensions =
        map (pkg: pkg.extensionUuid) config.gnome.enabledExtensions;
      disable-user-extensions = builtins.length config.gnome.enabledExtensions
        == 0;
    };
    home.packages = config.gnome.enabledExtensions + config.gnome.extraExtensions;
  };
}
