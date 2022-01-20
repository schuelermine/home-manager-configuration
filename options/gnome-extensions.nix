{ config, pkgs, lib, ... }: {
  options.gnome.enabledExtensions = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [ ];
    example = [ pkgs.gnomeExtensions.appindicator ];
    description =
      "List of packages that provide extensions that are to be enabled";
  };
  config.dconf.settings."org/gnome/shell" = {
    enabled-extensions =
      map (pkg: pkg.extensionUuid) config.gnome.enabledExtensions;
    disable-user-extensions = builtins.length config.gnome.enabledExtensions
      == 0;
  };
  config.home.packages = config.gnome.enabledExtensions;
}
