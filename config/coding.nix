{ config, lib, pkgs, ... }: {
  programs = {
    haskell = {
      ghcVersionName = "9.2.4";
      ghc.enable = true;
      cabal.enable = true;
    };
    rust = {
      rustc.enable = true;
      cargo.enable = true;
      rustfmt.enable = true;
      clippy.enable = true;
    };
  };
  home.packages = with pkgs; [ openjdk ];
}
