{ config, pkgs, lib, ... }:
with lib; {
  options.gnome = {
    enabledExtensions = mkOption {
      type = types.listOf types.package;
      default = [ ];
      example = [ pkgs.gnomeExtensions.appindicator ];
      exampleText = literalExpression "[ pkgs.gnomeExtensions.appindicator ]";
      description =
        "List of packages that provide extensions that are to be enabled.";
    };
    extra-extension = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Extra extension packages to install (but not enable).";
    };
  };
  config.dconf.settings."org/gnome/shell" = {
    enabled-extensions =
      map (pkg: pkg.extensionUuid) config.gnome.enabledExtensions;
    disable-user-extensions = builtins.length config.gnome.enabledExtensions
      == 0;
  };
  config.home.packages = config.gnome.enabledExtensions;
}
