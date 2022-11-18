{ config, pkgs, lib, ... }: {
  programs.vscode = rec {
    enable = true;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      bmalehorn.vscode-fish
      editorconfig.editorconfig
      firefox-devtools.vscode-firefox-debug
      github.vscode-pull-request-github
      mkhl.direnv
      ms-vscode.hexeditor
      redhat.vscode-xml
      redhat.vscode-yaml
      streetsidesoftware.code-spell-checker
      thenuprojectcontributors.vscode-nushell-lang
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

      "terminal.integrated.cursorStyle" = "line";
      "terminal.external.linuxExec" = "blackbox";

      "window.titleBarStyle" = "custom";
      "window.dialogStyle" = "custom";
      "window.menuBarVisibility" = "compact";
      "window.zoomLevel" = 1;

      "scm.diffDecorationsGutterPattern" = { modified = false; };
    };
  };
}
