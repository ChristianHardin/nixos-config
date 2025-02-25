# TO-DO
{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    zsh.enable =
      lib.mkEnableOption "enable zsh shell";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
    };
  };
}
