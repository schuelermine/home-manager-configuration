{ config, pkgs, lib, nixpkgs-master, ... }: {
  imports = [ ./kitty.nix ];
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
      package = pkgs.yaru-theme;
      name = "Yaru-dark";
      enable = true;
    };
    appTheme = {
      package = pkgs.yaru-theme;
      name = "Yaru-dark";
    };
    iconTheme = {
      package = pkgs.yaru-theme;
      name = "Yaru";
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
    vscode-fhs
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
  fonts.fonts = with pkgs; [
    zilla-slab
  ];
}
