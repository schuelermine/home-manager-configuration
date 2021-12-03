{ config, pkgs, lib, ... }: {
  imports = [ ./desktop.nix ./shell.nix ];
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
