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
    nixos-repl-setup = {
      flake = false;
      url = "github:schuelermine/nixos-repl-setup";
    };
    tetris.url = "github:schuelermine/tetris/add-nix-build";
    blender = {
      url = "github:edolstra/nix-warez?dir=blender";
      inputs.nixpkgs.follows = "system-config/nixpkgs";
    };
    ret.url = "github:schuelermine/ret";
  };
  outputs = { system-config, home-manager, nixos-repl-setup, nix-lib, tetris
    , blender, ret, nixpkgs, ... }:
    let
      lib1 = nix-lib.lib {
        nixpkgsLib = nixpkgs.lib;
        includeNixpkgsLib = false;
      };
      lib2 = import ./lib2.nix {
        lib = nixpkgs.lib;
        inherit lib1;
      };
    in {
      homeConfigurations.anselmschueler =
        home-manager.lib.homeManagerConfiguration rec {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          extraSpecialArgs = { inherit nixos-repl-setup lib1 lib2; };
          modules = map (path: ./options + "/${path}")
            (builtins.attrNames (builtins.readDir ./config))
            ++ map (path: ./options + "/${path}")
            (builtins.attrNames (builtins.readDir ./options)) ++ [{
              nixpkgs.overlays = [
                blender.overlays.default
                tetris.overlays.default
                ret.overlays.default
              ];
            }];
        };
    };
}
