{ config, pkgs, lib, ... }: {
  config = mkIf (config.gtk.enable
    && !builtins.elem config.gtk.theme.name or null [ null "" ]) {
      home.sessionVariables.GTK_THEME = config.gtk.theme.name;
    };
}
