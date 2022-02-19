{ config, pkgs, lib, ... }:
with builtins // lib;
let
  wrap = x: if isList x then x else [ x ];
  mkRenamedSuperoptionModules = n1: n2: k:
    map (g:
      let gs = wrap g;
      in mkRenamedOptionModule (wrap n1 ++ gs) (wrap n2 ++ gs)) (wrap k);
  cfg = config.gnome.extensions;
in {
  imports = mkRenamedSuperoptionModules "gnome" [ "gnome" "extensions" ] [
    "enabledExtensions"
    "extraExtensions"
  ];
  options.gnome.extensions = {
    enable = mkEnableOption "GNOME shell extensions" // {
      default = length cfg.enabledExtensions != 0;
    };
    enabledExtensions = mkOption {
      type = types.listOf types.package;
      default = [ ];
      defaultText = literalExpression "[ ]";
      example = literalExpression "[ pkgs.gnomeExtensions.appindicator ]";
      description =
        "List of packages that provide extensions that are to be enabled.";
    };
    extraExtensions = mkOption {
      type = types.listOf types.package;
      default = [ ];
      defaultText = literalExpression "[ ]";
      description = "Extra extension packages to install (but not enable).";
    };
  };
  config = {
    dconf.settings."org/gnome/shell" = {
      disable-user-extensions = !cfg.enable;
      enabled-extensions = map (pkg: pkg.extensionUuid) cfg.enabledExtensions;
    };
    home.packages = cfg.enabledExtensions ++ cfg.extraExtensions;
  };
}
