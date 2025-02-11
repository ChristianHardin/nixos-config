{
  config,
  pkgs,
  ...
}: {
  imports = [../../homeManagerModules];

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
    ];
  };

  programs.git = {
    enable = true;
    userName = "Christian A-H";
    userEmail = "contact@christianhardin.com";
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
    '';

    shellAliases = {};
  };

  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
