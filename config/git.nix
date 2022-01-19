{ config, pkgs, lib, ... }: {
  programs = {
    git = {
      userEmail = "mail@anselmschueler.com";
      userName = "Anselm Schüler";
      enable = true;
      delta.enable = true;
      package = pkgs.gitFull;
    };
    gh = {
      enable = true;
      enableGitCredentialHelper = true;
    };
  };
}
