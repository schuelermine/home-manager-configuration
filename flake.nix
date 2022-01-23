{
  # name = "anselm-schueler-home-manager-configuration";
  description = "Home manager configuration by Anselm Schüler";
  # license = builtins.readFile ./LICENSE;
  inputs = {
    system-config.url = "git+file:///etc/nixos";
    nix-lib.url = "github:schuelermine/nix-lib/b0";
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
        configuration = ./config/home.nix;
        extraSpecialArgs = { inherit fish-functions nix-lib; };
        extraModules = map (str: ./options + "/${str}") (builtins.attrNames
          (nix-lib.attrs.filter (_: t: t == "regular")
            (nix-lib.file.readDirRCollapsed ./options)));
      };
  };
}
