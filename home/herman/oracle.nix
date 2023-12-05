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
      name = "DP-2";
      width = 2560;
      height = 1440;
      refreshRate = 144;
      x = 0;
      workspace = "2";
    }
    {
      name = "DP-1";
      width = 2560;
      height = 1440;
      refreshRate = 144;
      x = 2560;
      workspace = "1";
      primary = true;
    }
    {
      name = "p2211H";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      x = 4480;
      workspace = "3";
    }
  ];
}