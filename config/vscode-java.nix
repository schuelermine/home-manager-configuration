{ config, pkgs, lib, ... }: {
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      redhat.java
      vscjava.vscode-java-debug
      vscjava.vscode-java-dependency
      vscjava.vscode-java-test
      vscjava.vscode-maven
    ];
    userSettings = {
      "java.configuration.runtimes" = [{
        "default" = true;
        "name" = "JavaSE-17";
        "path" = "${pkgs.openjdk}/lib/openjdk";
      }];
      "java.jdt.ls.java.home" = "${pkgs.openjdk}/lib/openjdk";
      "files.exclude" = {
        "**/.classpath" = true;
        "**/.project" = true;
        "**/.settings" = true;
        "**/.factorypath" = true;
      };
    };
  };
}
