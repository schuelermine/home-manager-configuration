{ config, pkgs, lib, ... }: {
  gnome = {
    extensions.enabledExtensions = with pkgs.gnomeExtensions; [
      appindicator
      gsconnect
    ];
    font = {
      package = pkgs.fira;
      name = "Fira Sans";
      size = 11;
    };
    monospaceFont = {
      package = pkgs.source-code-pro;
      name = "Source Code Pro";
      size = 14;
    };
    documentFont = {
      package = pkgs.fira;
      name = "Fira Sans";
      size = 11;
    };
    legacyTitlebarFont = {
      package = pkgs.fira;
      name = "Fira Sans weight=450";
      size = 11;
    };
    shellTheme = {
      package = pkgs.yaru-theme;
      name = "Yaru-dark";
    };
    gtkAppTheme = {
      package = pkgs.yaru-theme;
      name = "Yaru-dark";
    };
    gtkIconTheme = {
      package = pkgs.yaru-theme;
      name = "Yaru";
    };
  };
  qt = {
    enable = true;
    style = {
      package = pkgs.breeze-qt5;
      name = "breeze";
    };
  };
  home.packages = with pkgs; [
    spotify
    discord
    element-desktop
    signal-desktop
    apostrophe
    steam
  ];
}
