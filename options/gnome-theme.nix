{ config, pkgs, lib, ... }:
with lib // import ../alib.nix lib; {
  options.gnome.shellTheme = {
    enable = mkEnableOption "custom GNOME shell themes";
  } // mkProvidesOptionSet {
    providedText = "the custom shell theme";
    packageExample = "pkgs.yaru-theme";
    keyType = types.str;
    defaultKey = "";
    defaultKeyText = ''""'';
    keyExample = ''"Yaru"'';
  };
  config = let cfg = config.gnome.shellTheme;
  in mkIf cfg.enable {
    gnome.extensions.enabledExtensions = [ pkgs.gnomeExtensions.user-themes ];
    dconf.settings."org/gnome/shell/extensions/user-theme".name = cfg.name;
    home.packages = optional (cfg.package != null) cfg.package;
  };
}
