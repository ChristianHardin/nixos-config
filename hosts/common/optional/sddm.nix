{
  services = {
    xserver.enable = true;
    xserver.displayManager.sddm.enable = true;
    displayManager.defaultSession = "plasmawayland"; # or whatever you using
  };
}