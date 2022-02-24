{ config, pkgs, lib, ... }:
let cfg = config.gnome.cursorTheme;
in with lib // import ../alib.nix lib; {
  options.gnome.cursorTheme = mkProvidesOption {
    providedText = "the cursor theme";
    packageExample = "pkgs.yaru-theme";
    keyType = types.str;
    defaultKey = "";
    defaultKeyText = ''""'';
    keyExample = ''"Yaru"'';
  };
  config = {
    dconf.settings."org.gnome.desktop.interface".cursor-theme = cfg.name;
    home.packages = optional (cfg.package != null) cfg.package;
  };
}
