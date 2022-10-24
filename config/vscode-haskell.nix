{ config, pkgs, lib, ... }: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      haskell.haskell
      justusadam.language-haskell
    ];
  };
}
