{ lib, pkgs, ... }:
{
  programs.vscode = {
    mutableExtensionsDir = lib.mkForce true;
    extensions = lib.mkForce [ ];
    package = lib.mkForce pkgs.vscode-fhs;
  };
}
