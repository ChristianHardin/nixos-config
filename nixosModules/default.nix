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
}
