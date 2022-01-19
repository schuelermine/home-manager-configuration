{ config, pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.jetbrains-mono;
      name = "JetBrains Mono";
      size = 13;
    };
    keybindings = {
      "ctrl+tab" = "next_tab";
      "ctrl+shift+tab" = "previous_tab";
    };
    settings = {
      linux_display_server = "x11";
      cursor_shape = "underline";
      cursor_underline_thickness = 1;
      resize_in_steps = true;
    };
  };
}
