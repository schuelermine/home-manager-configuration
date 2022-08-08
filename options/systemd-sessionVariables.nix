{ config, pkgs, lib, lib1, ... }:
with builtins // lib // lib1;
let cfg = config.systemd.user;
in {
  options.systemd.user.copySessionVariables = mkEnableOption
    "copying all session variables to the systemd session variables";
  config.systemd.user.sessionVariables =
    mkIf cfg.copySessionVariables config.home.user;
}
