{ inputs, ...}: {
  imports = [ 
    ./global
    ./features/games
  ];

  monitors = [
    {
      name = "DP-1";
      width = 1920;
      height = 1200;
      refreshRate = 60;
      x = 0;
      workspace = "1";
      primary = true;
    }
  ];
}