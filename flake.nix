{
  description = "Nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Testing
    umu.url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    sops-nix,
    home-manager,
    alejandra,
    ...
  } @ inputs: {
    nixosConfigurations.oracle = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit self inputs;

        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };

        pkgs-unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
      modules = [
        # Default Config
        ./config/configuration.nix

        # Sops
        sops-nix.nixosModules.sops

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.herman = import ./home/home.nix;
        }

        # Formatting
        {
          environment.systemPackages = [alejandra.defaultPackage."x86_64-linux"];
        }
      ];
    };
  };
}
