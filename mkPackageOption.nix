lib: pkgs: name:
with lib;
{ default ? if isList name then name else [ name ], example ? null
, extraDescription ? "", }:
let
  name' = if isList name then last name else name;
  nullDefault = default == null;
  default' = if isList default then default else [ default ];
  defaultPath = concatStringsSep "." default';
  defaultValue = if nullDefault then
    null
  else
    attrByPath default' (throw "${defaultPath} cannot be found in pkgs") pkgs;
  defaultText =
    if nullDefault then "null" else literalExpression ("pkgs." + defaultPath);
  type = (if nullDefault then lib.types.nullOr else x: x) lib.types.package;
in mkOption {
  inherit type defaultText;
  description = "The ${name'} package to use."
    + (if extraDescription == "" then "" else " ") + extraDescription;
  default = defaultValue;
  ${if example != null then "example" else null} = literalExpression
    (if isList example then
      "pkgs." + concatStringsSep "." example
    else
      example);
}
