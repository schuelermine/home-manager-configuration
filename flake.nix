{
  # name = "anselm-schueler-home-manager-configuration";
  description = "Home manager configuration by Anselm Schüler";
  # license = builtins.readFile ./LICENSE;
  inputs = {
    system-config.url = "git+file:///etc/nixos?ref=b0";
    nixpkgs.follows = "system-config/nixpkgs";
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
    xhmm.url = "github:schuelermine/xhmm/b0";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { system-config, home-manager, nixos-repl-setup, tetris, blender
    , nixpkgs, xhmm, fenix, ... }:
    let system = "x86_64-linux";
    in {
      homeConfigurations.anselmschueler =
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            inherit nixos-repl-setup;
            fenix = fenix.packages.${system};
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
