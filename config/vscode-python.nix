{ config, pkgs, ... }: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      matangover.mypy
      ms-python.python
      ms-pyright.pyright
      ms-toolsai.jupyter
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow
    ];
    userSettings = {
      "mypy.dmypyExecutable" = "${config.programs.python.mypy.package}/bin/dmypy";
      "python.defaultInterpreterPath" = "${config.programs.python.package}/bin/python";
      "python.formatting.provider" = "black";
      "python.formatting.blackPath" = "${pkgs.black}/bin/black";
    };
  };
}
