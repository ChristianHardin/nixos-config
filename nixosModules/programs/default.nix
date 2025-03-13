{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./neovim
    ./gnupg
    ./umu-launcher
    ./kdeconnect
  ];

  umu-launcher.enable = lib.mkDefault false;
  gnupg.enable = lib.mkDefault false;
  neovim.enable = lib.mkDefault true;
  kdeconnect.enable = lib.mkDefault false;
}
