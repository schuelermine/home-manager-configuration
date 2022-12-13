{
  # name = "anselm-schueler-home-manager-configuration";
  description = "Home manager configuration by Anselm Schüler";
  # license = builtins.readFile ./LICENSE;
  inputs = {
    system-config.url = "git+file:///etc/nixos?ref=b0";
    nixpkgs.follows = "system-config/nixpkgs";
    nixpkgs-test.url =
      "github:eadwu/nixpkgs/vscode-with-extensions/extensions-json";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-repl-setup = {
      flake = false;
      url = "github:schuelermine/nixos-repl-setup";
    };
    tetris.url = "github:schuelermine/tetris/add-nix-build";
    blender = {
      url = "github:edolstra/nix-warez?dir=blender";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xhmm.url = "github:schuelermine/xhmm/b0";
  };
  outputs = { home-manager, nixos-repl-setup, tetris, blender, nixpkgs, xhmm
    , nixpkgs-test, ... }: {
      homeConfigurations.anselmschueler =
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          extraSpecialArgs = {
            inherit nixos-repl-setup;
            nixpkgs-test = import nixpkgs-test {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
          modules = [ xhmm.homeManagerModules.all ]
            ++ map (path: ./config + "/${path}")
            (builtins.attrNames (builtins.readDir ./config))
            ++ map (path: ./options + "/${path}")
            (builtins.attrNames (builtins.readDir ./options)) ++ [{
              nixpkgs.overlays =
                [ blender.overlays.default tetris.overlays.default ];
            }];
        };
    };
}
