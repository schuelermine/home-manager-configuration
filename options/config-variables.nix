{ pkgs, lib, lib1, lib2, ... }:
with builtins // lib // lib1 // lib2;
let
  mkModule = { name, varName ? toUpper (head (split " " name))
    , optionName ? snakeCase name }:
    { config, ... }:
    with types;
    let
      cfg = config.home.${optionName};
      moduleType = mkProvidesType {
        providedText = "the ${name}";
        packageExample = "pkgs.nano";
        keyName = "executable";
        keyType = nullOr (oneOf [ str path ]);
        defaultKey = null;
        defaultKeyText = "null";
        keyExample = ''"nano"'';
      };
    in {
      options.home.${optionName} = mkOption {
        type = nullOr (oneOf [ str moduleType ]);
        default = null;
        description = ''
          The ${name} to use. This sets the <code>${varName}</code> variable.
          Can be a string or a submodule specifying a <code>package</code> and an <code>executable</code>.
        '';
      };
      config = {
        home.packages =
          mkIf (isAttrs cfg && cfg.package != null) [ cfg.package ];
        systemd.user.sessionVariables = {
          ${guardNull cfg varName} =
            if isString cfg then cfg else toString cfg.executable;
        };
      };
    };
in {
  imports = map mkModule [
    { name = "editor"; }
    { name = "visual editor"; }
    { name = "pager"; }
  ];
}
