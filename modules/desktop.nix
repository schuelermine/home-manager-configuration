{ config, pkgs, lib, ... }: {
  imports = [ ./kitty.nix ];
  gnome.enabledExtensions = with pkgs.gnomeExtensions; [
    appindicator
    user-themes
  ];
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
  dconf.settings = {
    "org/gnome/shell/extensions/user-theme".name = "Yaru";
    "org/gnome/desktop/interface".monospace-font-name = "JetBrains Mono 10";
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
    qbittorrent
    obs-studio
    asciinema
    gitui
    apostrophe
  ];
}
