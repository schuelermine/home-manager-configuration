{ config, pkgs, lib, ... }: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      llvm-vs-code-extensions.vscode-clangd
      ms-vscode.cmake-tools
      ms-vscode.makefile-tools
      twxs.cmake
      vadimcn.vscode-lldb
    ];
    userSettings = {
      "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
      "cmake.cmakePath" = "${pkgs.cmake}/bin/cmake";
      "makefile.makePath" = "${pkgs.gnumake}/bin/make";
    };
  };
}
