{
  # name = "anselm-schueler-home-manager-configuration";
  description = "Home manager configuration by Anselm Schüler";
  # license = builtins.readFile ./LICENSE;
  inputs = {
    system-config.url = "git+file:///etc/nixos?ref=b0";
    nixpkgs.follows = "system-config/nixpkgs";
    nix-lib.url = "github:schuelermine/nix-lib/b0";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "system-config/nixpkgs";
    };
    fish-functions = {
      flake = false;
      url = "github:schuelermine/fish-functions";
    };
    nixos-repl-setup = {
      flake = false;
      url = "github:schuelermine/nixos-repl-setup";
    };
    tetris.url = "github:schuelermine/tetris/add-nix-build";
    blender = {
      url = "github:schuelermine/nix-warez/blender-improved?dir=blender";
      inputs.nixpkgs.follows = "system-config/nixpkgs";
    };
  };
  outputs = { system-config, home-manager, fish-functions, nixos-repl-setup
    , nix-lib, tetris, blender, nixpkgs, ... }:
    let
      lib1 = nix-lib.lib {
        nixpkgsLib = nixpkgs.lib;
        includeNixpkgsLib = false;
      };
      lib2 = import ./lib2 lib1;
    in {
      homeConfigurations.anselmschueler =
        home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          homeDirectory = "/home/anselmschueler";
          username = "anselmschueler";
          stateVersion = "21.11";
          configuration = ./config/home.nix;
          extraSpecialArgs = {
            inherit fish-functions nixos-repl-setup lib1 lib2;
          };
          extraModules = map (path: ./options + "/${path}")
            (builtins.attrNames (builtins.readDir ./options))
            ++ # Overlays for packages
            [{
              nixpkgs.overlays =
                [ blender.overlays.default tetris.overlays.default ];
            }];
        };
    };
}
