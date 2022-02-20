lib:
let
  guard = cond: name: if cond then name else null;
  guardNull = value: guard (value != null);
in with lib;
{ providedText, defaultPackage ? null, defaultPackageText ? "null"
, packageExample ? null, keyName ? "name", keyType ? types.nullOr types.str
, defaultKey ? null, defaultKeyText ? ''""'', keyExample ? null }: {
  package = mkOption {
    type = types.nullOr types.package;
    default = defaultPackage;
    defaultText = literalExpression defaultPackageText;
    ${guardNull packageExample "example"} = literalExpression packageExample;
    description = ''
      Package providing ${providedText}. This package will be installed to your profile.
      If <literal>null</literal> then the theme is assumed to already be available in your profile.
    '';
  };
  ${keyName} = mkOption {
    type = keyType;
    default = defaultKey;
    defaultText = literalExpression defaultKeyText;
    ${guardNull keyExample "example"} = literalExpression keyExample;
    description = "Name of ${provided} within the package.";
  };
}
