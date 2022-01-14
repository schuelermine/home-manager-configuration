{ config, pkgs, lib, fish-functions, nix-lib, ... }:
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
        l = "ls -a";
        ls = "exa";
        cd = "z";
        c = "bat";
        icat = "kitty +kitten icat";
        uni = "kitty +kitten unicode_input";
      };
      functions = nix-lib.attrs.mapX (filename: type:
        if type == "regular" then
          let matches = builtins.match "(.+)\\.fish" filename;
          in if builtins.length matches == 1 then {
            ${builtins.elemAt matches 0} =
              builtins.readFile "${fish-functions}/${filename}";
          } else
            { }
        else
          { }) (nix-lib.file.readDirRecursive "${fish-functions}");
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
      glow
    ];
  };
}
