{ config, pkgs, lib, ... }:
let cfg = config.gnome.cursorTheme;
in with lib // import ../alib.nix lib; {
  imports = [
    (mkProvidesModule {
      providedText = "the cursor theme";
      packageExample = ''"pkgs.yaru-theme"'';
      keyType = types.str;
      defaultKey = "Adwaita";
      defaultKeyText = ''"Adwaita"'';
      keyExample = ''"Yaru"'';
      prefix = [ "gnome" "cursorTheme" ];
    })
  ];
  config.dconf.settings."org/gnome/desktop/interface".cursor-theme =
    mkIf (cfg != null && cfg.name != null && cfg.name != "")
    cfg.name; # In case the Adwaita default is changed
}
