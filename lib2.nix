nixpkgs-lib:
with nixpkgs-lib // builtins; rec {
  impossible = throw "This error message should never occur.";
  guardKey = cond: name: if cond then name else null;
  guardKeyNull = value: guardKey (value != null);
  id = x: x;
  compose = f1: f2: x: f1 (f2 x);
  compose12 = f: g: x: f (g x x);
  compose21 = g: f1: f2: x: g (f1 x) (f2 x);
  composeN = foldl' compose id;
  dupArgs = f: x: f x x;
  sandwich = x: xs: [ x ] ++ xs ++ [ x ];
  mkList = x: xs: [ x ] ++ xs;
  reList = f1: f2: xs: mkList (f1 (head xs)) (f2 (tail xs));
  onList = f: compose21 f head tail;
  mapHead = f: xs: mkList (f (head xs)) (tail xs);
  mkNestedAttrs = path: value:
    if path == [ ] then
      value
    else {
      ${head path} = mkNestedAttrs (tail path) value;
    };
  filterSegments = compose concatLists
    (map (x: if isList x then x else if x == "" then [ ] else [ x ]));
  splitChars = str: filterSegments (split "" str);
  concatStrings = foldl' (c1: c2: c1 + c2) "";
  asChars = f: str: concatStrings (f (splitChars str));
  capitalize = asChars (mapHead toUpper);
  wrap = x: if isList x then x else [ x ];
  words = str: filterSegments (split " " str);
  snakeCase = str: concatStrings (reList id (map capitalize) (words str));
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
        ${guardKeyNull packageExample "example"} =
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
        ${guardKeyNull keyExample "example"} = literalExpression keyExample;
        description =
          "${initialKeyText} of ${providedText} within the package.";
      };
    };
}
