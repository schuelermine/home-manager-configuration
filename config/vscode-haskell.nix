{ config, pkgs, lib, ... }: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      haskell.haskell
      justusadam.language-haskell
    ];
    userSettings = {
      "haskell.serverExecutablePath" =
        "${pkgs.haskellPackages.haskell-language-server}/bin/haskell-language-server-wrapper";
    };
  };
}
