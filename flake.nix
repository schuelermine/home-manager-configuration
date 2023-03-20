{
  # name = "anselm-schueler-home-manager-configuration";
  description = "Home manager configuration by Anselm Schüler";
  # license = builtins.readFile ./LICENSE;
  inputs = {
    system-config.url = "github:schuelermine/nixos-configuration";
    nixpkgs.follows = "system-config/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "system-config/nixpkgs";
    };
    nixos-repl-setup = {
      flake = false;
      url = "github:schuelermine/nixos-repl-setup";
    };
    xhmm.url = "github:schuelermine/xhmm/b0";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { home-manager, nixos-repl-setup, nixpkgs, xhmm, fenix, ... }:
    let system = "x86_64-linux";
    in {
      homeConfigurations.anselmschueler =
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            inherit nixos-repl-setup;
            fenix = fenix.packages.${system};
          };
          modules = [ xhmm.homeManagerModules.all ] ++ (with builtins;
            map (path: ./config + "/${path}") (attrNames (readDir ./config)));
        };
    };
}
