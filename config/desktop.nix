{ config, pkgs, lib, ... }: {
  imports = [ ./kitty.nix ];
  gnome = {
    enabledExtensions = with pkgs.gnomeExtensions; [
      dash-to-dock
      appindicator
    ];
    monospaceFont = {
      package = pkgs.fira-code;
      name = "Fira Code";
      size = 10;
    };
    shellTheme = {
      enable = true;
      package = pkgs.yaru-theme;
      name = "Yaru";
    };
  };
  gtk = {
    enable = true;
    font = {
      package = pkgs.ibm-plex;
      name = "IBM Plex Sans Text";
      size = 11;
    };
    iconTheme = {
      package = pkgs.yaru-theme;
      name = "Yaru";
    };
    theme = {
      package = pkgs.yaru-theme;
      name = "Yaru-dark";
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
    gnome.dconf-editor
    libqalculate
    lutris
    minecraft
    discord
    element-desktop
    tdesktop
    musescore
    inkscape
    audacity
    vscode
    kdenlive
    virt-manager
    transmission-gtk
    obs-studio
    asciinema
    gitui
    apostrophe
  ];
}
