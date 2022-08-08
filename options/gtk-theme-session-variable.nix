{ config, pkgs, lib, ... }: {
  options.gtk.useThemeSessionVariable = lib.mkEnableOption ''
    using the GTK_THEME environment variable to configure the GTK theme.
    This forces libadwaita apps to take on the theme.
  '';

  config = lib.mkIf (config.gtk.enable && config.gtk.useThemeSessionVariable
    && !builtins.elem config.gtk.theme.name or null [ null "" ]) {
      sessionVariables.GTK_THEME = config.gtk.theme.name;
    };
}
