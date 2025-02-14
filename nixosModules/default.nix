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
    ./neovim
  ];

  flatpak.enable = lib.mkDefault false;
  steam-devices.enable = lib.mkDefault false;
  umu-launcher.enable = lib.mkDefault false;
  gnupg.enable = lib.mkDefault false;
  neovim.enable = lib.mkDefault true;
}
