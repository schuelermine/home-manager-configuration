{ config, pkgs, lib, ... }:
with builtins // lib;
let cfg = config.programs.haskell.language-server;
    ghcVersionName = config.programs.haskell.ghcVersionName;
    pkgConfigurable =
      cfg.package.override.__functionArgs ? supportedGhcVersions;
    pkgConfigured = if pkgConfigurable && ghcVersionName != null
      then cfg.package.override {
        supportedGhcVersions = [ ghcVersionName ] ++ cfg.extraSupportedGhcVersions;
      }
      else cfg.package;
in {
  options.programs.haskell.language-server = {
    enable = mkEnableOption "the Haskell Language Server";
    package = mkPackageOption pkgs "HLS" {
      default = [ "haskell-language-server" ];
    };
    extraSupportedGhcVersions = mkOption {
      type = with types; listOf str;
      description = "The GHC Versions to support with HLS.";
      default = [ ];
      defaultText = literalExpression "null";
      example = literalExpression ''[ "902" ]'';
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ pkgConfigured ];
    warnings = mkIf (!pkgConfigurable) [''
      You have provided a package as programs.haskell.language-server.package that doesn't allow overriding supportedGhcPackages.
      This disables specifying supported GHC versions via programs.haskell.language-server.extraSupportedGhcVersions.
      It is recommended to use pkgs.haskell-language-server or a derivative, not a HLS from haskellPackages or similar.
    ''];
  };
}
