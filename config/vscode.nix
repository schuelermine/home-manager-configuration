{ config, pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;
    userSettings = {
      "update.mode" = "none";

      "editor.fontFamily" = config.gnome.monospaceFont.name;
      "editor.fontLigatures" = true;

      "window.titleBarStyle" = "custom";
      "window.menuBarVisibility" = "compact";

      "workbench.productIconTheme" = "icons-carbon";
      "workbench.colorTheme" = "IBM Carbon Color Theme";
      "workbench.iconTheme" = "vs-nomo-dark";

      "java.configuration.runtimes" = [{
        "default" = true;
        "name" = "JavaSE-17";
        "path" = "${pkgs.openjdk}/lib/openjdk";
      }];
      "haskell.serverExecutablePath" =
        "${pkgs.haskell-language-server}/bin/haskell-language-server";
      "makefile.makePath" = "${pkgs.gnumake}/bin/make";

      "files.insertFinalNewline" = true;

      "editor.insertSpaces" = true;

      "[nix]" = {
        "editor.tabSize" = 2;
        "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
        "editor.formatOnSave" = true;
      };
    };
  };
}