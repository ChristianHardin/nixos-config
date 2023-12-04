{ inputs, pkgs,...}: {
  imports = [ 
    ./global
    ./features/games
    ./features/cli
  ];

  home.packages = with pkgs; [ 
    dbeaver
  ];

  monitors = [
    {
      name = "DP-1";
      width = 2560;
      height = 1440;
      refreshRate = 144;
      x = 0;
      workspace = "1";
      primary = true;
    }
  ];
}