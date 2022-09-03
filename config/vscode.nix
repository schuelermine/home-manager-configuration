{ config, pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    userSettings = {
      "update.mode" = "none";

      "editor.fontFamily" = config.gnome.monospaceFont.name;
      "editor.fontSize" = config.gnome.monospaceFont.size;
      "editor.fontLigatures" = true;

      "window.titleBarStyle" = "custom";
      "window.dialogStyle" = "custom";
      "files.simpleDialog.enable" = true;
      "window.menuBarVisibility" = "compact";
      "window.zoomLevel" = 1;

      "workbench.productIconTheme" = "icons-carbon";
      "workbench.colorTheme" = "IBM Carbon Color Theme";
      "workbench.iconTheme" = "vs-nomo-dark";

      "java.configuration.runtimes" = [{
        "default" = true;
        "name" = "JavaSE-17";
        "path" = "${pkgs.openjdk}/lib/openjdk";
      }];
      "haskell.serverExecutablePath" =
        "${config.programs.haskell.haskellPackages.haskell-language-server}/bin/haskell-language-server";
      "makefile.makePath" = "${pkgs.gnumake}/bin/make";
      "powershell.powerShellAdditionalExePaths" = {
        ${pkgs.powershell.version} = "${pkgs.powershell}/bin/pwsh";
      };
      "cmake.cmakePath" = "${pkgs.cmake}/bin/cmake";
      "rust-analyzer.server.path" =
        "${config.programs.rust.rust-analyzer.package}/bin/rust-analyzer";

      "gitlens.codeLens.enabled" = false;

      "editor.inlineSuggest.enabled" = true;
      "editor.acceptSuggestionOnEnter" = "off";

      "files.insertFinalNewline" = true;
      "editor.insertSpaces" = true;

      "[nix]" = {
        "editor.tabSize" = 2;
        "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
      };

      "[rust]" = { "editor.formatOnSave" = true; };

      "[haskell]" = { "editor.tabSize" = 2; };
    };
  };
}
