{
  inputs = {
    system-config.url = "git+file:///etc/nixos";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "system-config/nixos";
  };
  outputs = { system-config, home-manager, self }: {
    homeConfigurations.anselmschueler =
      home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/anselmschueler";
        username = "anselmschueler";
        stateVersion = "21.11";
        configuration = ./modules/home.nix;
        extraModules = [ ./modules/gnome.nix ];
      };
  };
}
