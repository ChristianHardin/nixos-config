{pkgs, ...}: {
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable printer discovery viw ipp
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Additional Printer Drivers
  services.printing.drivers = [pkgs.gutenprint];
}
