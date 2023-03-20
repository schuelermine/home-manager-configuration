{ pkgs, ... }: {
  programs = {
    git = {
      userEmail = "mail@anselmschueler.com";
      userName = "Anselm Schüler";
      enable = true;
      delta.enable = true;
      package = pkgs.gitFull;
      extraConfig.init.defaultBranch = "b0";
    };
    gh = {
      enable = true;
      enableGitCredentialHelper = true;
    };
  };
}
