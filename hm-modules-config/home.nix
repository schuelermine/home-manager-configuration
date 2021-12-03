{ config, pkgs, lib, ... }: {
  imports = [
    ../hm-modules-options/gnome.nix
    ./desktop.nix
    ./shell.nix
  ];
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
