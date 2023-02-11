{ config, lib, pkgs, fenix, ... }: {
  programs = {
    haskell = {
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
    rust.customToolchain.toolchainPackage = fenix.stable.toolchain;
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
  home.packages = with pkgs; [ openjdk clang gdb ];
}
