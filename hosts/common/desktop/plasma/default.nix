{ ... }:
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
}
