{ config, pkgs, lib, ... }: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      ms-pyright.pyright
      ms-python.python
      ms-toolsai.jupyter
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow
    ];
    userSettings = {
      "python.pythonPath" = "${pkgs.python3}/bin/python";
    };
  };
}
