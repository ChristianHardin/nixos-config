{ inputs, outputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./zsh.nix
    ./locale.nix
    ./openssh.nix
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}