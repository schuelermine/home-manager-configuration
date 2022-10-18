{ config, pkgs, lib, ... }: {
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    ms-vscode.cpptools
  ];
}
