{ config, pkgs, lib, ... }: {
  imports = [ ./kitty.nix ];
  gnome = {
    extensions.enabledExtensions = with pkgs.gnomeExtensions; [ appindicator ];
    font = {
      package = pkgs.fira;
      name = "Fira Sans";
      size = 11;
    };
    monospaceFont = {
      package = pkgs.fira-code;
      name = "Fira Code";
      size = 11;
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
      package = pkgs.flat-remix-gnome;
      name = "Flat Remix";
      enable = true;
    };
    appTheme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat Remix";
    };
    iconTheme = {
      package = pkgs.flat-remix-icon-theme;
      name = "Flat Remix";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };
  home.packages = with pkgs; [
    spotify
    github-desktop
    gnome.dconf-editor
    libqalculate
    lutris
    minecraft
    discord
    element-desktop
    tdesktop
    signal-desktop
    musescore
    inkscape
    audacity
    vscode
    rnix-lsp
    kdenlive
    virt-manager
    transmission-gtk
    obs-studio
    asciinema
    gitui
    apostrophe
    drawio
  ];
}
