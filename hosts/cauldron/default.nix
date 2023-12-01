{ pkgs, inputs, ...}:
{
  imports = [
    # Nixos Hardware https://github.com/NixOS/nixos-hardware/tree/master
    inputs.hardware.nixosModules.dell-xps-15-9510
    # inputs.hardware.nixosModules.dell-xps-15-9510-nvidia
    inputs.hardware.nixosModules.common-gpu-nvidia-disable

    # Nix Ld https://github.com/Mic92/nix-ld
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
    ../common/optional/opengl.nix
  ];

  networking = {
    hostName = "cauldron";
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  hardware.opengl.enable = true;

  system.stateVersion = "23.05";
}