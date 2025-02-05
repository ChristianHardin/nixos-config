{pkgs, ...}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  virtualisation.waydroid.enable = false;

  environment.systemPackages = with pkgs; [
    distrobox
  ];
}
