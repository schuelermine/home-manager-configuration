{
    inputs = {
        system-config.url = "git+file:///etc/nixos";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "system-config/nixos";
    };
    outputs = { system-config, home-manager }: let nixos = system-config.inputs.nixos;
    in {
        homeConfigurations.anselmschueler = home-manager.lib.homeManagerConfiguration {
            system = "x86_64-linux";
            homeDirectory = "/home/anselmschueler";
            username = "anselmschueler";
            configuration = ./home.nix;
        };
    };
}