{ config, lib, pkgs, ... }: {
  programs = {
    haskell = {
      ghcVersionName = "9.0.2";
      ghc = {
        enable = true;
        ghciConfig = ''
          :set +m
          :set +t
          :set +s
        '';
      };
      cabal.enable = true;
      stack.enable = true;
    };
    rust = {
      rustc.enable = true;
      cargo.enable = true;
      rustfmt.enable = true;
      clippy.enable = true;
    };
    python = {
      versionName = "3.10";
      enable = true;
      packages = pypkgs: with pypkgs; [ hypothesis click libcst ];
      mypy = {
        enable = true;
      };
      pytest.enable = true;
    };
  };
  home.packages = with pkgs; [ openjdk clang ];
}
