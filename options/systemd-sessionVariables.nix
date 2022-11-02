{ config, pkgs, lib, ... }:
with builtins // lib;
let cfg = config.systemd.user;
in {
  options.systemd.user.copySessionVariables = mkEnableOption
    "copying all session variables to the systemd session variables";
  config.systemd.user.sessionVariables =
    mkIf cfg.copySessionVariables config.home.sessionVariables;
}
