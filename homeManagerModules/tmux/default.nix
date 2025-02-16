{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    tmux.enable =
      lib.mkEnableOption "enable tmux";
  };

  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      prefix = "C-a";
      keyMode = "vi";
      terminal = "xterm-256color";
      clock24 = true;
      historyLimit = 100000;

      plugins = with pkgs; [];

      extraConfig = ''
      '';
    };
  };
}
