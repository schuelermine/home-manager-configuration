{
  inputs = {
    system-config.url = "git+file:///etc/nixos";
    nix-lib.url = "github:schuelermine/nix-lib";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "system-config/nixpkgs";
    };
    fish-functions = {
      flake = false;
      url = "github:schuelermine/fish-functions";
    };
  };
  outputs = { system-config, home-manager, fish-functions, nix-lib, self }: {
    homeConfigurations.anselmschueler =
      home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/anselmschueler";
        username = "anselmschueler";
        stateVersion = "21.11";
        configuration = ./modules/home.nix;
        extraSpecialArgs = { inherit fish-functions nix-lib; };
        extraModules = [ ./modules/gnome.nix ];
      };
  };
}
