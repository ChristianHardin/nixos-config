{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.desktop;
  discover-wrapped = pkgs.symlinkJoin
    {
      name = "discover-flatpak-backend";
      paths = [ pkgs.libsForQt5.discover ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/plasma-discover --add-flags "--backends flatpak"
      '';
    };
in
{
  imports = [
  ];

  services.xserver = {
    # Enable the Plasma desktop.
    desktopManager.plasma5.enable = true;
  };

  # Enable Bluetooth support.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    discover-wrapped
  ];
}
