# https://wiki.nixos.org/wiki/Docker
{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    docker.enable =
      lib.mkEnableOption "enable docker";
  };

  config = lib.mkIf config.docker.enable {
    virtualisation.docker.enable = true;
  };
}
