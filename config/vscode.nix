{ config, pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
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
