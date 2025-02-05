{pkgs-unstable, ...}: {
  fonts.packages = with pkgs-unstable; [
    nerd-fonts.fira-code
  ];
}
