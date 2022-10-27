{ config, pkgs, lib, ... }: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools
    ];
    userSettings = {
      "C_Cpp.formatting" = "clangFormat";
      "C_Cpp.clang_format_path" = "${pkgs.clang-tools}/bin/clang-format";
      "cmake.cmakePath" = "${pkgs.cmake}/bin/cmake";
      "makefile.makePath" = "${pkgs.gnumake}/bin/make";
    };
  };
}
