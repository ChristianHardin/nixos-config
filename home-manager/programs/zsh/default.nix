{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -l";
      cat = "bat";
      ls = "exa";
      update = "sudo nixos-rebuild switch --flake /home/herman/Documents/nix-config/#oracle && home-manager switch --flake /home/herman/Documents/nix-config/#herman@oracle";
      update-config = "sudo nixos-rebuild switch --flake /home/herman/Documents/nix-config/#oracle";
      update-home = "home-manager switch --flake /home/herman/Documents/nix-config/#herman@oracle";
    };
  };
}