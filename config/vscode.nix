{ config, pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      editorconfig.editorconfig
      mkhl.direnv
      github.vscode-pull-request-github
      streetsidesoftware.code-spell-checker
    ];
    package = pkgs.vscode;
    userSettings = {
      "update.mode" = "none";

      "editor.fontFamily" = config.gnome.monospaceFont.name;
      "editor.fontSize" = config.gnome.monospaceFont.size;
      "editor.fontLigatures" = true;

      "window.titleBarStyle" = "custom";
      "window.dialogStyle" = "custom";
      "window.menuBarVisibility" = "compact";
      "window.zoomLevel" = 1;
    };
  };
}
