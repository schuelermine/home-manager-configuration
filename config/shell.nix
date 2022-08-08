{ config, pkgs, lib, nixos-repl-setup, ... }: {
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
      haskellPackages = pkgs.haskell.packages.ghc923;
      ghc = {
        enable = true;
        packages = hkgs:
          with hkgs; [
            primitive
            random
            vector
            monad-coroutine
            Boolean
          ];
      };
      cabal.enable = true;
      stack.enable = true;
      language-server.enable = true;
    };
    rust.rustup.enable = true;
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    exa.enable = true;
    direnv.enable = true;
    nushell = {
      enable = true;
      configFile.text = builtins.concatStringsSep "\n" [
        (builtins.readFile ../source/config.default.nu)
        (builtins.readFile ../source/config.nu)
      ];
      envFile.text = builtins.concatStringsSep "\n" [
        (builtins.readFile ../source/env.default.nu)
        (builtins.readFile ../source/env.nu)
      ];
    };
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
      prompt = builtins.readFile ../source/prompt.fish;
      shellInit = builtins.concatStringsSep "\n" [
        (builtins.readFile ../source/colors.fish)
        (builtins.readFile ../source/features.fish)
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
      duf
      execline
      fd
      figlet
      fortune
      fq
      fzf
      gh
      gitui
      glow
      gnuapl
      haskellPackages.hoogle
      jacinda
      jc
      jp
      jq
      libguestfs
      links2
      lolcat
      lr
      lua
      moreutils
      ncdu
      neofetch
      nix-index
      nix-info
      nix-top
      nixfmt
      nixpkgs-fmt
      nms
      nnn
      nodejs_latest
      nodePackages.typescript
      num-utils
      moreutils
      openjdk
      pick
      powershell
      procs
      python310
      ret
      ripgrep
      sl
      sqlite
      tetris
      toilet
      unicode-paracode
      unzip
      weechat
      whois
      with-shell
    ];
  };
}
