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
      terminal = "tmux-256color";
      keyMode = "vi";
      mouse = true;
      historyLimit = 100000;
      plugins = with pkgs; [];
      extraConfig = ''
        # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"
      '';
    };
  };
}
