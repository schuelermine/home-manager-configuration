{ config, pkgs, lib, ... }:
let mkProvidesOption = import ../mkProvidesOption.nix lib;
in with lib; {
  options.gnome.shellTheme = {
    enable = mkEnableOption "custom GNOME shell themes";
  } // mkProvidesOption {
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
