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
      clock24 = true;
      keyMode = "vi";
      mouse = true;
      terminal = "xterm-256color";
      historyLimit = 100000;
      plugins = with pkgs; [];
    };
  };
}
