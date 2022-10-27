{ config, pkgs, lib, ... }: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      firefox-devtools.vscode-firefox-debug
    ];
  };
}
