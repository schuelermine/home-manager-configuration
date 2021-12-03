{
  inputs = {
    system-config.url = "git+file:///etc/nixos";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "system-config/nixos";
  };
  outputs = { system-config, home-manager, self }:
    let nixos = system-config.inputs.nixos;
    in {
      homeConfigurations.anselmschueler =
        home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          homeDirectory = "/home/anselmschueler";
          username = "anselmschueler";
          stateVersion = "21.11";
          configuration = ./hm-modules-config/home.nix;
          extraModules = ./hm-modules-options/gnome.nix;
        };
    };
}
