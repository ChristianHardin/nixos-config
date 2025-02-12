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
    ./gnupg
  ];

  flatpak.enable = lib.mkDefault false;
  steam-devices.enable = lib.mkDefault false;
  umu-launcher.enable = lib.mkDefault false;
  gnupg.enable = lib.mkDefault false;
}
