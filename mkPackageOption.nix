lib: pkgs: name:
with builtins;
with lib;
{ default ? [ name ], example ? null }:
let default' = if !isList default then [ default ] else default;
in mkOption {
  type = types.package;
  description = "The ${name} package to use.";
  default = attrByPath default'
    (throw "${concatStringsSep "." default'} cannot be found in pkgs") pkgs;
  defaultText = literalExpression ("pkgs." + concatStringsSep "." default');
  ${if example != null then "example" else null} = literalExpression
    (if isList example then
      "pkgs." + concatStringsSep "." example
    else
      example);
}
