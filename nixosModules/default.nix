{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./desktop/plasma
    ./apps
    ./flatpak
    ./steam-devices
  ];

  flatpak.enable = lib.mkDefault true;
  steam-devices.enable = lib.mkDefault false;
}
