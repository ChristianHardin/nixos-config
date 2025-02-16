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
      clock24 = true;
      historyLimit = 100000;

      plugins = with pkgs; [];

      extraConfig = ''
        # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
        #set -g default-terminal "xterm-256color"
        #set -ga terminal-overrides ",*256col*:Tc"
        #set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        #set-environment -g COLORTERM "truecolor"

        # Color
        set -g defualt_terminal "$TERM"
        set -ag terminal-overrides ",$TERM:Tc"

        #Prefix is Ctrl-a
        set -g prefix C-a
        bind C-a send-prefix
        unbind C-b

        set -sg escape-time 1
        set -g base-index 1
        setw -g pane-base-index 1

        #Mouse works as expected
        set -g mouse on

        setw -g monitor-activity on
        set -g visual-activity on

        set -g mode-keys vi
        set -g history-limit 10000

        # y and p as in vim
        bind Escape copy-mode
        unbind p
        bind p paste-buffer
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection
        bind-key -T copy-mode-vi 'Space' send -X halfpage-down
        bind-key -T copy-mode-vi 'Bspace' send -X halfpage-up

        # extra commands for interacting with the ICCCM clipboard
        #bind C-c run "tmux save-buffer - | xclip -i -sel clipboard"
        #bind C-v run "tmux set-buffer \"$(xclip -o -sel clipboard)\"; tmux paste-buffer"
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy && wl-paste -n | wl-copy -p"
        bind-key p run "wl-paste -n | tmux load-buffer - ; tmux paste-buffer"

        # easy-to-remember split pane commands
        bind | split-window -h
        bind - split-window -v
        unbind '"'
        unbind %

        # moving between panes with vim movement keys
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # moving between windows with vim movement keys
        bind -r C-h select-window -t :-
        bind -r C-l select-window -t :+

        # resize panes with vim movement keys
        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5
      '';
    };
  };
}
