{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  home = {
    homeDirectory = "/home/anselmschueler";
    username = "anselmschueler";
    stateVersion = "21.11";
  };
  systemd.user.copySessionVariables = true;
}
