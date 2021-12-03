{ config, pkgs, lib, ... }: {
  programs = {
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
  };

}
