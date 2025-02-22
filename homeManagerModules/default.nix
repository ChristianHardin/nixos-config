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
    ./bash
    ./zsh
  ];

  neovim.enable = lib.mkDefault false;
  tmux.enable = lib.mkDefault false;
  starship.enable = lib.mkDefault false;
  bash.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault false;
}
