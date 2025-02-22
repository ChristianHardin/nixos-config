{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./neovim
    ./tmux
    ./starship
  ];

  neovim.enable = lib.mkDefault false;
  tmux.enable = lib.mkDefault false;
  starship.enable = lib.mkDefault false;
}
