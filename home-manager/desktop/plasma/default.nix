{ ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";

    displayManager = {
      sddm.enable = true;
      defaultSession = "plasmawayland";
    };

    desktop.plasma5.enable = true;

    # Enable Bluetooth support.
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}