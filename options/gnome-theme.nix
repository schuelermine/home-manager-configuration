{ config, pkgs, lib, ... }:
let cfg = config.gnome.shellTheme;
in with lib // import ../alib.nix lib; {
  imports = [
    (mkProvidesModule {
      providedText = "the custom shell theme";
      packageExample = "pkgs.yaru-theme";
      keyType = types.str;
      defaultKey = "";
      defaultKeyText = ''""'';
      keyExample = ''"Yaru"'';
      prefix = [ "gnome" "shellTheme" ];
      onlyIf = cfg.enable;
      extraModules =
        [{ options.enable = mkEnableOption "custom GNOME shell themes"; }];
    })
    (mkAliasOptionModule [ "gnome" "appTheme" ] [ "gtk" "theme" ])
    (mkAliasOptionModule [ "gnome" "iconTheme" ] [ "gtk" "iconTheme" ])
  ];
  config = mkIf cfg.enable {
    gnome.extensions.enabledExtensions = [ pkgs.gnomeExtensions.user-themes ];
    dconf.settings."org/gnome/shell/extensions/user-theme".name = cfg.name;
  };
}
