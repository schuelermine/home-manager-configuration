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
      package = pkgs.go-font;
      name = "Go Mono";
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
    gnome.dconf-editor
    libqalculate
    lutris
    discord
    element-desktop
    tdesktop
    signal-desktop
    musescore
    inkscape
    audacity
    kdenlive
    virt-manager
    transmission-gtk
    obs-studio
    asciinema
    apostrophe
    drawio
    blender_3_4
    steam
  ];
  fonts.fonts = with pkgs; [ zilla-slab fira ];
  fonts.fontconfig.enable = true;
}
