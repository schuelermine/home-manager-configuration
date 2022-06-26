{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = (_: true);
  programs.home-manager.enable = true;
  homeDirectory = "/home/anselmschueler";
  username = "anselmschueler";
  stateVersion = "21.11";
}
