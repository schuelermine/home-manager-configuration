{ config, lib, pkgs, ... }: {
  programs = {
    haskell = {
      ghcVersionName = "9.4.2";
      ghc = {
        enable = true;
        ghciConfig = ''
          :set +m
          :set +t
          :set +s
        '';
      };
      cabal = {
        enable = true;
        config = "";
      };
      stack = {
        enable = true;
        settings = { };
      };
    };
    rust = {
      rustc.enable = true;
      cargo = {
        enable = true;
        settings = { };
      };
      rustfmt = {
        enable = true;
        settings = { };
      };
      clippy.enable = true;
    };
    python = {
      versionName = "3.10";
      enable = true;
      packages = pypkgs: with pypkgs; [ hypothesis click libcst ];
      mypy = {
        enable = true;
        settings = { };
      };
      pytest.enable = true;
      pip = {
        enable = true;
        settings = { };
      };
    };
  };
  home.packages = with pkgs; [ openjdk ];
}
