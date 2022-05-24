{ config, pkgs, lib, fish-functions, nix-lib, ... }:
let
  editor =
    "nano --smarthome --boldtext --tabstospaces --historylog --positionlog --softwrap --zap --atblanks --autoindent --cutfromcursor --linenumbers --mouse --indicator --afterends --suspendable --stateflags";
in {
  imports = [ ./git.nix ];
  programs = {
    haskell = {
      ghc.enable = true;
      cabal.enable = true;
      language-server.enable = true;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    exa.enable = true;
    direnv.enable = true;
    nushell.enable = true;
    fish = {
      enable = true;
      shellAliases = {
        nano = editor;
        sl = "sl -e";
        ls = "exa --sort=type";
        ll = "ls --classify --long";
        la = "ls --classify --all";
        l- = "ls --classify --long --all";
        cd = "z";
        c = "bat";
        icat = "kitty +kitten icat";
        uni = "kitty +kitten unicode_input";
      };
      functions = nix-lib.attrs.mapX (filename: type:
        if type == "regular" then
          let matches = builtins.match "(.+)\\.fish" filename;
          in if matches != null && builtins.length matches == 1 then {
            ${builtins.elemAt matches 0} =
              builtins.readFile "${fish-functions}/${filename}";
          } else
            { }
        else
          { }) (nix-lib.file.readDirRCollapsed "${fish-functions}");
      prompt = builtins.readFile ../source/fish_prompt.fish;
      shellInit = builtins.concatStringsSep "\n" [
        (builtins.readFile ../source/colors.fish)
        ''
          set fish_features stderr-nocaret qmark-noglob regex-easyesc ampersand-nobg-in-token
        ''
      ];
    };
  };
  home = {
    inherit editor;
    packages = with pkgs; [
      bat
      bit
      boxes
      browsh
      btop
      chafa
      cmatrix
      cowsay
      deno
      execline
      fd
      figlet
      fq
      fzf
      gh
      glow
      gnuapl
      jacinda
      jc
      jd
      jl
      jp
      jq
      links2
      lolcat
      lr
      lua
      unzip
      moreutils
      neofetch
      nixfmt
      nixpkgs-fmt
      nms
      nnn
      nodejs_latest
      num-utils
      openjdk
      pick
      powershell
      procs
      python310
      ripgrep
      sl
      sqlite
      tetris
      toilet
      trash-cli
      unicode-paracode
      weechat
      whois
      with-shell
    ];
    file.jdk-link = {
      target = ".openjdk";
      source = "${pkgs.openjdk}";
    };
  };
}
