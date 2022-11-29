{ config, lib, pkgs, ... }: {
  programs = {
    haskell = {
      ghcVersionName = "9.4.2";
      ghc.enable = true;
      cabal.enable = true;
    };
    rust = {
      rustc.enable = true;
      cargo.enable = true;
      rustfmt.enable = true;
      clippy.enable = true;
    };
    python = {
      versionName = "3.11";
      enable = true;
      packages = pypkgs: with pypkgs; [
        hypothesis
      ];
      mypy.enable = true;
      pytest.enable = true;
    };
  };
  home.packages = with pkgs; [ openjdk ];
}
