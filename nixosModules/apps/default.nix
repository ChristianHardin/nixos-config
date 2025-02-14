{pkgs, ...}: {
  imports = [
    ./fonts
    ./virtualization
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    wget

    # Archive
    p7zip
    rar

    # Monitoring
    htop
    btop
    nvtopPackages.full
    dmidecode

    # Sop-nix
    sops

    # Clipboard
    wl-clipboard
    xclip
  ];
}
