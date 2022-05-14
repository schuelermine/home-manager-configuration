{ config, pkgs, lib, ... }: {
  imports = [ ./desktop.nix ./shell.nix ];
  nixpkgs.config.allowUnfreePredicate = (_: true);
  programs.home-manager.enable = true;
}
