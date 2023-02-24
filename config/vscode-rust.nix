{ config, pkgs, lib, fenix, ... }: {
  programs = {
    vscode = {
      extensions = with pkgs.vscode-extensions; [ rust-lang.rust-analyzer ];
      userSettings = {
        "[rust]"."editor.formatOnSave" = true;
        "rust-analyzer.server.path" =
          "${config.programs.rust.rust-analyzer.package}/bin/rust-analyzer";
        "rust-analyzer.checkOnSave.command" = "check";
        "rust-analyzer.inlayHints.maxLength" = 25;
      };
    };
    rust.exposeRustSrcLocation = "${fenix.latest.rust-src}";
  };
}
