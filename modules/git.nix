{ config, pkgs, lib, ... }: {
  programs = {
    git = {
      userEmail = "mail@anselmschueler.com";
      userName = "Anselm Schüler";
      enable = true;
      delta.enable = true;
      package = pkgs.gitAndTools.gitFull;
    };
    gh = {
      enable = true;
      enableGitCredentialHelper = true;
    };
  };
}
