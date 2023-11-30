{
  description = "Yogurt";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    
    home-manager= {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
  in {
    inherit lib;
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      oracle =  lib.nixosSystem {
        modules = [ ./hosts/oracle ];
        specialArgs = { inherit inputs outputs; };
      };

      cauldron =  lib.nixosSystem {
        modules = [ ./hosts/cauldron ];
        specialArgs = { inherit inputs outputs; };
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "herman@oracle" = lib.homeManagerConfiguration {
        modules = [ ./home/herman/oracle.nix ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
      };

      "herman@cauldron" = lib.homeManagerConfiguration {
        modules = [ ./home/herman/cauldron.nix ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
  };
}
