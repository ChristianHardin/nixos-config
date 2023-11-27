{ ... }: {
  imports = [
    ./common
    ./plasma
  ];

  services.xserver = {
    enable = true;
    layout = "us";

    displayManager = {
      sddm.enable = true;
      defaultSession = "plasmawayland";
    };
  };
}