{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./flatpak
    ./steam-devices
    ./docker
    ./podman
  ];

  flatpak.enable = lib.mkDefault false;
  steam-devices.enable = lib.mkDefault false;
  docker.enable = lib.mkDefault false;
  podman.enable = lib.mkDefault false;
}
