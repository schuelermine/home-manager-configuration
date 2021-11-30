{ config, pkgs, lib, ... }:
let
  editor =
    "nano --smarthome --boldtext --tabstospaces --historylog --positionlog --softwrap --zap --atblanks --autoindent --cutfromcursor --linenumbers --mouse --indicator --afterends --suspendable --stateflags";
in {
  imports = [ ./hm-modules/gnome.nix ];

  programs.home-manager.enable = true;

  programs = {
    kitty = {
      enable = true;
      font = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
        size = 13;
      };
      keybindings = {
        "ctrl+tab" = "next_tab";
        "ctrl+shift+tab" = "previous_tab";
      };
      settings = {
        linux_display_server = "x11";
        cursor_shape = "underline";
        cursor_underline_thickness = 1;
        resize_in_steps = true;
      };
    };
    fish = {
      enable = true;
      shellAliases = {
        nano = editor;
        sl = "sl -e";
        ls = "exa";
        cd = "z";
        cat = "bat";
      };
      functions = {
        "..." = ''
          set -q argv[1] || set argv[1] 2
          set dest $PWD
          for i in (seq $argv[1])
            set dest (dirname $dest)
          end
          isatty stdout && cd $dest || echo $dest
        '';
      };
      shellInit = ''
        set -U fish_color_autosuggestion brblack
        set -U fish_color_cancel --reverse white
        set -U fish_color_command bryellow
        set -U fish_color_comment brgreen
        set -U fish_color_cwd brgreen
        set -U fish_color_cwd_root brred
        set -U fish_color_end brmagenta
        set -U fish_color_error white
        set -U fish_color_escape yellow
        set -U fish_color_hg_added green
        set -U fish_color_hg_clean green
        set -U fish_color_hg_copied magenta
        set -U fish_color_hg_deleted red
        set -U fish_color_hg_dirty red
        set -U fish_color_hg_modified yellow
        set -U fish_color_hg_renamed magenta
        set -U fish_color_hg_unmerged red
        set -U fish_color_hg_untracked yellow
        set -U fish_color_history_current --underline
        set -U fish_color_host normal
        set -U fish_color_host_remote bryellow
        set -U fish_color_keyword brcyan
        set -U fish_color_match --reverse
        set -U fish_color_normal white
        set -U fish_color_operator brcyan
        set -U fish_color_param brblue
        set -U fish_color_quote brgreen
        set -U fish_color_redirection brmagenta
        set -U fish_color_search_match --reverse
        set -U fish_color_selection --reverse white
        set -U fish_color_status red
        set -U fish_color_user brgreen
        set -U fish_color_valid_path --underline
        set -U fish_pager_color_background black
        set -U fish_pager_color_completion normal
        set -U fish_pager_color_description normal
        set -U fish_pager_color_prefix normal
        set -U fish_pager_color_progress --reverse white
      '';
    };
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
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    exa.enable = true;
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
    sessionVariables = { EDITOR = editor; };
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
