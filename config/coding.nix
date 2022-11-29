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
        settings.mypy.strict = true;
      };
      pytest.enable = true;
      pip.enable = true;
    };
  };
  home.packages = with pkgs; [ openjdk ];
}
