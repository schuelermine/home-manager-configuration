{ pkgs, ... }: {
  programs = {
    git = {
      userEmail = "mail@anselmschueler.com";
      userName = "Anselm Schüler";
      enable = true;
      delta.enable = true;
      package = pkgs.gitFull;
      extraConfig = {
        init.defaultBranch = "b0";
        safe.directory = [
          "/etc/nixos"
        ];
      };
    };
    gh = {
      enable = true;
      enableGitCredentialHelper = true;
    };
  };
}
