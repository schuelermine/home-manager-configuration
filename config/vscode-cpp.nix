{ config, pkgs, lib, ... }: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools
    ];
    userSettings = {
      "C_Cpp.formatting" = "clangFormat";
      "cmake.cmakePath" = "${pkgs.cmake}/bin/cmake";
      "makefile.makePath" = "${pkgs.gnumake}/bin/make";
    };
  };
}
