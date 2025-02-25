{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./programs
    ./services
  ];
}
