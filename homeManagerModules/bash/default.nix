{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    bash.enable =
      lib.mkEnableOption "enable bash shell";
  };

  config = lib.mkIf config.bash.enable {
    programs.bash = {
      enable = true;

      bashrcExtra = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
      '';

      shellAliases = {};
    };
  };
}
