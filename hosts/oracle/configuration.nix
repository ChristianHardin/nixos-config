{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  programs.nix-ld.enable = true; # tmp
  programs.gamemode.enable = true;
  services.fwupd.enable = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "spinner";
    };

    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
  };

  networking.hostName = "oracle";
  networking.networkmanager.enable = true;

  users.users.herman = {
    isNormalUser = true;
    description = "Herman";
    extraGroups = ["networkmanager" "wheel" "input" "gamemode"];
    packages = with pkgs; []; # User packages in home
  };

  system.stateVersion = "24.11";
}
