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
        set stateflags
      '';
    };
    haskell = {
      haskellPackages = pkgs.haskell.packages.ghc924;
      ghc.enable = true;
      cabal.enable = true;
      stack.enable = true;
      language-server.enable = true;
    };
    rust = {
      rustc.enable = true;
      cargo.enable = true;
      rustfmt.enable = true;
      clippy.enable = true;
      rust-analyzer.enable = true;
      exposeRustSrcLocation = true;
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
      prompt = builtins.readFile ../source/prompt.fish;
      shellInit = builtins.concatStringsSep "\n" (map builtins.readFile [
        ../source/colors.fish
        ../source/features.fish
        ../source/commands.fish
      ]);
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
      haskellPackages.ret
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
