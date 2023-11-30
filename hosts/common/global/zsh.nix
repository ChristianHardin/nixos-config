{ config, ... }:
let 
  hostName = config.networking.hostName;
in 
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      cat = "bat";
      ls = "eza";
      update = "sudo nixos-rebuild switch --flake /home/herman/Documents/nix-config/#${hostName} && home-manager switch --flake /home/herman/Documents/nix-config/#herman@${hostName}";
      update-config = "sudo nixos-rebuild switch --flake /home/herman/Documents/nix-config/#${hostName}";
      update-home = "home-manager switch --flake /home/herman/Documents/nix-config/#herman@${hostName}";
    };
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}