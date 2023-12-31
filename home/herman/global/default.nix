{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      # outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  home = {
    username = lib.mkDefault "herman";
    homeDirectory = lib.mkDefault "/home/herman";
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "$HOME/Documents/nix-config";
    };
  };

  # FLATPAK
  # firefox 
  # thunderbird
  # discord
  # libreoffice-fresh
  # bottles
  # moonlight-qt

  home.packages = with pkgs; [ 
    bitwarden
    nextcloud-client
    bat
    libsForQt5.yakuake
    eza
    vscode
    wineWowPackages.waylandFull
    p7zip
    unrar
    mpv
    protontricks

    # Fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
  ];
  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName  = "ChristianHardin";
    userEmail = "christianhardin12345@gmail.com";
  };

  systemd.user.startServices = "sd-switch";
}
