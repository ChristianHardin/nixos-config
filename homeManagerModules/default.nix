{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./neovim
  ];

  neovim.enable = lib.mkDefault false;
}
