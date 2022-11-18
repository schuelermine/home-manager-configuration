{ config, pkgs, lib, ... }: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      matangover.mypy
      ms-python.python
      ms-toolsai.jupyter
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow
    ];
    userSettings = {
      "mypy.dmypyExecutable" = "${pkgs.mypy}/bin/mypy";
      "python.pythonPath" = "${pkgs.python3}/bin/python";
    };
  };
}
