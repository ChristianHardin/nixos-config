{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./desktop/plasma
    ./apps
    # Modules Below
    ./flatpak
    ./steam-devices
    ./umu-launcher
  ];

  flatpak.enable = lib.mkDefault true;
  steam-devices.enable = lib.mkDefault false;
  umu-launcher.enable = lib.mkDefault false;
}
