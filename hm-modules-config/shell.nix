{ config, pkgs, lib, ... }:
let
  editor =
    "nano --smarthome --boldtext --tabstospaces --historylog --positionlog --softwrap --zap --atblanks --autoindent --cutfromcursor --linenumbers --mouse --indicator --afterends --suspendable --stateflags";
in {
  imports = [ ./git.nix ];
  programs = {
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
        ls = "exa";
        cd = "z";
        c = "bat";
      };
      functions = { "..." = builtins.readFile ../source/....fish; };
      shellInit = builtins.readFile ../source/colors.fish;
    };
  };
  home = {
    sessionVariables.EDITOR = editor;
    packages = with pkgs; [
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
    ];
  };
}
