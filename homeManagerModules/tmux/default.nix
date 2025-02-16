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
      shell = "\${pkgs.bash}/bin/bash";
      clock24 = true;
      keyMode = "vi";
      mouse = true;
      terminal = "tmux-256color";
      historyLimit = 100000;
      plugins = with pkgs; [];
    };
  };
}
