{ config, pkgs, lib, ... }: {
  programs = {
    vscode = {
      extensions = with pkgs.vscode-extensions; [
        haskell.haskell
        justusadam.language-haskell
      ];
      userSettings = {
        "haskell.serverExecutablePath" =
          "${config.programs.haskell.language-server.package}/bin/haskell-language-server-wrapper";
      };
    };
  };
}
