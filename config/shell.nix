{ config, pkgs, lib, fish-functions, nix-lib, ... }:
let
  editor =
    "nano --smarthome --boldtext --tabstospaces --historylog --positionlog --softwrap --zap --atblanks --autoindent --cutfromcursor --linenumbers --mouse --indicator --afterends --suspendable --stateflags";
in {
  imports = [ ./git.nix ];
  programs = {
    haskell.ghc = {
      enable = true;
      package = pkgs.haskell.packages.ghc921.ghc;
      packages = hkgs: [ hkgs.primes ];
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    exa.enable = true;
    fish = {
      enable = true;
      shellAliases = {
        nano = editor;
        sl = "sl -e";
        ls = "exa --grid";
        ll = "exa --grid --classify --long";
        la = "exa --grid --classify --all";
        l- = "exa --grid --classify --long --all";
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
      shellInit = builtins.readFile ../source/colors.fish;
    };
  };
  home = {
    sessionVariables.EDITOR = editor;
    packages = with pkgs; [
      bat
      bit
      cowsay
      figlet
      fzf
      gh
      glow
      jc
      jq
      links2
      lolcat
      lr
      nixfmt
      nnn
      pick
      procs
      sl
      sqlite
      steam-run
      steamPackages.steamcmd
      toilet
      unicode-paracode
      weechat
      whois
      with-shell
    ];
  };
}
