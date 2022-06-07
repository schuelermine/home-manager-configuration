{ lib, lib1 }:
with lib // lib1; rec {
  impossible = throw "This error message should never occur.";
  mkRenamedSuperoptionModules = n1: n2: k:
    map (g:
      let gs = wrap g;
      in mkRenamedOptionModule (wrap n1 ++ gs) (wrap n2 ++ gs)) (wrap k);
  mkProvidesOption = args@{ providedText
    , initialProvidedText ? capitalize providedText, defaultPackage ? null
    , defaultPackageText ? "null", packageExample ? null, keyName ? "name"
    , keyType ? types.nullOr types.str, defaultKey ? null
    , defaultKeyText ? ''""'', keyExample ? null, keyText ? keyName
    , initialKeyText ? capitalize keyText, extraModules ? [ ] }:
    mkOption { # TODO: Add custom description
      description = ''
        ${initialProvidedText} to use.
      '';
      type = mkProvidesType args;
      default = { };
    };
  mkProvidesType = args@{ extraModules ? [ ], ... }:
    types.submoduleWith {
      modules = [{
        options = mkProvidesOptionSet (removeAttrs args [ "extraModules" ]);
      }] ++ extraModules;
    };
  mkProvidesModule = args@{ prefix ? [ ], packagesLoc ? [ "home" "packages" ]
    , onlyIf ? true, ... }:
    { config, ... }:
    let
      args' = removeAttrs args [ "prefix" "packagesLoc" "onlyIf" ];
      cfg = attrByPath prefix impossible config;
    in {
      options = mkNestedAttrs prefix (mkProvidesOption args');
      config = mkNestedAttrs packagesLoc
        (optional (cfg.package != null && onlyIf) cfg.package);
    };
  mkProvidesOptionSet = args@{ providedText
    , initialProvidedText ? capitalize providedText, defaultPackage ? null
    , defaultPackageText ? "null", packageExample ? null, keyName ? "name"
    , keyType ? types.nullOr types.str, defaultKey ? null
    , defaultKeyText ? ''""'', keyExample ? null, keyText ? keyName
    , initialKeyText ? capitalize keyText }: {
      package = mkOption {
        type = types.nullOr types.package;
        default = defaultPackage;
        defaultText = literalExpression defaultPackageText;
        ${guardNull packageExample "example"} =
          literalExpression packageExample;
        description = ''
          Package providing ${providedText}. This package will be installed to your profile.
          If <literal>null</literal> then ${providedText} is assumed to already be available in your profile.
        '';
      };
      ${keyName} = mkOption {
        type = keyType;
        default = defaultKey;
        defaultText = literalExpression defaultKeyText;
        ${guardNull keyExample "example"} = literalExpression keyExample;
        description =
          "${initialKeyText} of ${providedText} within the package.";
      };
    };
}
