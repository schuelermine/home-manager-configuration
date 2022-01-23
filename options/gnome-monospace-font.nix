{ config, pkgs, lib, ... }:
with lib; {
  options.gnome.monospaceFont = mkOption {
    type = hm.types.fontType;
    default = null;
    description = "The monospace font to use in Gnome and applications.";
  };
  config = let font = config.gnome.monospaceFont;
  in {
    dconf.settings."org/gnome/desktop/interface/".monospace-font-name =
      mkIf (font != null)
      (font.name + (if font.size != null then " ${font.size}" else ""));
    home.packages = optional (cfg.package != null) cfg.package;
  };
}
