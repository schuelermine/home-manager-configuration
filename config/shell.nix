{ config, pkgs, lib, lib1, nixos-repl-setup, ... }: {
  imports = [ ./git.nix ];
  programs = {
    less = {
      enable = true;
      options = [ "-r" ];
    };
    nano = {
      enable = true;
      config = ''
        set smarthome
        set boldtext
        set tabstospaces
        set historylog
        set positionlog
        set softwrap
        set zap
        set atblanks
        set autoindent
        set linenumbers
        set cutfromcursor
        set mouse
        set indicator
        set afterends
        set suspendable
        set stateflags
      '';
    };
    haskell = {
      ghc = {
        enable = true;
        packages = hkgs: [ primes singletons singletons-base ];
      };
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
      functions = { }; # TODO Migrate fish-functions o’er ’ere
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
    file."repl.nix".text = ''
      let repl-setup = import ${nixos-repl-setup};
      in repl-setup { source = "git+file:///etc/nixos"; isUrl = true; } // builtins
    '';
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
  };
}
