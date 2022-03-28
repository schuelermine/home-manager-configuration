{ config, pkgs, lib, nixpkgs-yaru, ... }: {
  imports = [ ./kitty.nix ];
  gnome = {
    extensions.enabledExtensions = with pkgs.gnomeExtensions; [ appindicator ];
    monospaceFont = {
      package = pkgs.fira-code;
      name = "Fira Code";
      size = 10;
    };
    shellTheme = {
      enable = true;      
      name = "Yaru";
    };
    cursorTheme.name = "Adwaita";
  };
  gtk = {
    enable = true;
    font = {
      package = pkgs.ibm-plex;
      name = "IBM Plex Sans Text";
      size = 11;
    };
    iconTheme = {
      package = nixpkgs-yaru.legacyPackages.x86_64-linux.yaru-theme;
      name = "Yaru";
    };
    theme = {
      package = nixpkgs-yaru.legacyPackages.x86_64-linux.yaru-theme;
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
    spotify
    github-desktop
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
