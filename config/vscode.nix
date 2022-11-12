{ config, pkgs, lib, ... }: {
  programs.vscode = rec {
    enable = true;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      editorconfig.editorconfig
      github.vscode-pull-request-github
      mkhl.direnv
      ms-vscode.hexeditor
      streetsidesoftware.code-spell-checker
      redhat.vscode-yaml
    ];
    package = pkgs.vscode;
    userSettings = {
      "update.mode" = "none";

      "editor.fontFamily" = config.gnome.monospaceFont.name;
      "editor.fontSize" = config.gnome.monospaceFont.size;
      "editor.fontLigatures" = true;

      "editor.codeLensFontFamily" = userSettings."editor.fontFamily";
      "editor.codeLensFontSize" = userSettings."editor.fontSize";

      "editor.inlayHints.enabled" = true;

      "editor.bracketPairColorization.enabled" = true;
      "editor.stickyScroll.enabled" = true;

      "editor.acceptSuggestionOnEnter" = "off";

      "files.insertFinalNewline" = true;
      "editor.insertSpaces" = true;

      "window.titleBarStyle" = "custom";
      "window.dialogStyle" = "custom";
      "window.menuBarVisibility" = "compact";
      "window.zoomLevel" = 1;

      "scm.diffDecorationsGutterPattern" = { modified = false; };
    };
  };
}
