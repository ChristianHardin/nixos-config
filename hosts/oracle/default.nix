{ pkgs, inputs, ...}:
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-hdd
    inputs.nix-ld.nixosModules.nix-ld

    ./hardware-configuration.nix

    ../common/global
    ../common/users/herman
    ../common/desktop/plasma
    ../common/optional/systemd-boot.nix
    ../common/optional/sddm.nix
    ../common/optional/pipewire.nix
    ../common/optional/spotifyd.nix
    ../common/optional/networkmanager.nix
  ];

  networking = {
    hostName = "oracle";
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  hardware.opengl.enable = true;

  system.stateVersion = "23.05";
}