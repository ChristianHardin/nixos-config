{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./neovim
    ./tmux
  ];

  neovim.enable = lib.mkDefault false;
  tmux.enable = lib.mkDefault false;
}
