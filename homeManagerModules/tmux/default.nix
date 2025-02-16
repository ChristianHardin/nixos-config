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
      shortcut = "a";
      keyMode = "vi";
      terminal = "xterm-256color";
      clock24 = true;
      historyLimit = 100000;

      plugins = with pkgs; [];

      extraConfig = ''
        # Mouse works as expected
          	set-option -g mouse on
          	# easy-to-remember split pane commands
          	bind | split-window -h -c "#{pane_current_path}"
          	bind - split-window -v -c "#{pane_current_path}"
          	bind c new-window -c "#{pane_current_path}"
      '';
    };
  };
}
