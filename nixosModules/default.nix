{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./desktop/plasma
    ./apps
		./flatpak
  ];

  flatpak.enable = lib.mkDefault true;
}
