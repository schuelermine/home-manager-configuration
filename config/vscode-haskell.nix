{ config, pkgs, lib, ... }: {
  programs = {
    vscode = {
      extensions = with pkgs.vscode-extensions; [
        haskell.haskell
        justusadam.language-haskell
      ];
      userSettings = {
        "haskell.serverExecutablePath" =
          "${config.programs.haskell.hls.package}/bin/haskell-language-server-wrapper";
      };
    };
  };
}
