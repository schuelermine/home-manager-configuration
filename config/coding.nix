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
    };
  };
  home.packages = with pkgs; [ openjdk ];
}
