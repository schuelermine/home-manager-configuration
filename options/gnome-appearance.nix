{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.gnome;
in
{
  imports = [
    (mkProvidesModule {
      providedText = "the custom shell theme";
      packageExample = "pkgs.yaru-theme";
      keyType = types.str;
      defaultKey = "";
      defaultKeyText = ''""'';
      keyExample = ''"Yaru"'';
      prefix = [ "gnome" "shellTheme" ];
      onlyIf = cfg.shellTheme.enable;
    })
    (mkAliasOptionModule [ "gnome" "appTheme" ] [ "gtk" "theme" ])
    (mkAliasOptionModule [ "gnome" "iconTheme" ] [ "gtk" "iconTheme" ])
  ];
  options.gnome.shellTheme = {
    enable = mkEnableOption "custom GNOME shell themes";
  };
  config = mkMerge [
    (mkIf cfg.shellTheme.enable {
      gnome.extensions.enabledExtensions = [ pkgs.gnomeExtensions.user-themes ];
      dconf.settings."org/gnome/shell/extensions/user-theme".name =
        cfg.shellTheme.name;
    })
    (mkIf (cfg.appTheme != null || cfg.iconTheme != null) {
      gtk.enable = true;
    })
  ];
}
