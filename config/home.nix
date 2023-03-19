{
  nixpkgs.config.allowUnfreePredicate = (_: true);
  programs.home-manager.enable = true;
  home = {
    homeDirectory = "/home/anselmschueler";
    username = "anselmschueler";
    stateVersion = "21.11";
  };
}
