{ ... }:
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
      update = "sudo nixos-rebuild switch --flake /home/herman/Documents/nix-config/#oracle && home-manager switch --flake /home/herman/Documents/nix-config/#herman@oracle";
      update-config = "sudo nixos-rebuild switch --flake /home/herman/Documents/nix-config/#oracle";
      update-home = "home-manager switch --flake /home/herman/Documents/nix-config/#herman@oracle";
    };
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}