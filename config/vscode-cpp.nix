{ config, pkgs, lib, ... }: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      llvm-vs-code-extensions.vscode-clangd
    ];
    userSettings = {
      "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
    };
  };
}
