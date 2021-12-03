{ config, pkgs, lib, ... }: {
  imports = [
    ../hm-modules-options/gnome.nix
    ./hm-modules-config/desktop.nix
    ./hm-modules-config/shell.nix
  ];
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
