{ config, pkgs, lib, ... }: {
  imports = [ ./hm-modules/gnome.nix ];

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  programs = {

    git = {
      userEmail = "mail@anselmschueler.com";
      userName = "Anselm Schüler";
      enable = true;
      delta.enable = true;
    };
    gh = {
      enable = true;
      enableGitCredentialHelper = true;
    };
  };
  gnome.enabledExtensions = with pkgs.gnomeExtensions; [
    appindicator
    user-themes
  ];
  gtk = let
    yaru = pkgs.yaru-theme.overrideAttrs ({ ... }: {
      src = pkgs.fetchFromGitHub {
        owner = "ubuntu";
        repo = "yaru";
        rev = "1c5edde454ca39d21e89f0b19e4f42544e8f9e81";
        hash = "sha256-zYlShPn8dLT+R5aw/wK+OtlQK0rD8jyNqYTfk4iT39s=";
      };
    });
  in {
    enable = true;
    font = {
      package = pkgs.ibm-plex;
      name = "IBM Plex Sans Text";
      size = 11;
    };
    iconTheme = {
      package = yaru;
      name = "Yaru";
    };
    theme = {
      package = yaru;
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
  home = {
    packages = with pkgs;
      [
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
        # (pkgs.blender.override { cudaSupport = true; })
        virt-manager
        qbittorrent
        obs-studio
        asciinema
        gnomeExtensions.appindicator
      ] ++ [
        gh
        steamPackages.steamcmd
        steam-run
        bind.dnsutils
        whois
        nixfmt
        sqlite
        sl
        figlet
        toilet
        lolcat
        weechat
        nnn
        links2
        unicode-paracode
        bat
        lr
        procs
        bit
        gitui
      ];
  };
}
