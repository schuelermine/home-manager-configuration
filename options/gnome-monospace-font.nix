{ config, pkgs, lib, ... }: {
  options.gnome.monospaceFont = lib.mkOption {
    type = lib.hm.types.fontType;
    default = null;
    description = "The monospace font to use in Gnome and applications.";
  };
  config.dconf.settings."org/gnome/desktop/interface/".monospace-font-name =
    let font = config.gnome.monospaceFont;
    in lib.mkIf (font != null) (builtins.concatStringSep " "
      ([ font.name ] + optional (font.size != null) font.size));
}

