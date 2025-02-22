{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "herman";
    homeDirectory = "/home/herman";
    packages = with pkgs; [
      scanmem
      devenv
      (import ./rebuild.nix {inherit pkgs;})
      (import ./rebuild-home.nix {inherit pkgs;})
    ];
  };

  programs.git = {
    enable = true;
    userName = "Christian A-H";
    userEmail = "contact@christianhardin.com";
  };

  neovim.enable = true;
  tmux.enable = true;
  starship.enable = true;

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
