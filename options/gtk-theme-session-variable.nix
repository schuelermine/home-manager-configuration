{ config, pkgs, lib, ... }: {
  config = lib.mkIf (config.gtk.enable
    && !builtins.elem config.gtk.theme.name or null [ null "" ]) {
      systemd.user.sessionVariables.GTK_THEME = config.gtk.theme.name;
    };
}
