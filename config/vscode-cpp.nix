{ config, pkgs, lib, ... }: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      llvm-vs-code-extensions.vscode-clangd
      ms-vscode.cmake-tools
      ms-vscode.cpptools
      ms-vscode.makefile-tools
      twxs.cmake
    ];
    userSettings = {
      "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
      "cmake.cmakePath" = "${pkgs.cmake}/bin/cmake";
      "makefile.makePath" = "${pkgs.gnumake}/bin/make";
      "C_Cpp.autocomplete" = "Disabled";
      "C_Cpp.formatting" = "Disabled";
      "C_Cpp.errorSquiggles" = "Disabled";
      "C_Cpp.intelliSenseEngine" = "Disabled";
    };
  };
}
