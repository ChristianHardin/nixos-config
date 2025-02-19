{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-amd" "zenpower"];
  boot.extraModulePackages = [config.boot.kernelPackages.zenpower];
  boot.kernelParams = ["amd_pstate=active"];
  boot.blacklistedKernelModules = ["k10temp"];
  boot.supportedFilesystems = ["ntfs"];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b942aa59-2db0-43c9-890b-1a19d38b9207";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DC8E-17A8";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  fileSystems."/steamlibrary" = {
    device = "/dev/disk/by-uuid/6a6170ab-7481-4e33-9477-f5cd5e58c2db";
    fsType = "ext4";
    options = ["x-systemd.automount" "noauto" "nofail"];
  };

  fileSystems."/blue" = {
    device = "/dev/disk/by-uuid/46D46DE4D46DD729";
    fsType = "ntfs-3g";
    options = ["x-systemd.automount" "noauto" "nofail"];
  };

  fileSystems."/windows" = {
    device = "/dev/disk/by-uuid/E82C07C82C0790AC";
    fsType = "ntfs-3g";
    options = ["x-systemd.automount" "noauto" "nofail"];
  };

  fileSystems."/Exodus" = {
    device = "192.168.10.52:/mnt/Temporary/Exodus";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=1800" "nofail"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/4410a971-bb89-4ae7-a0dc-e59ef163006b";}
  ];

  # AMD CPU
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # AMD GPU
  services.xserver.videoDrivers = lib.mkDefault ["modesetting"];

  hardware.graphics = {
    enable = lib.mkDefault true;
    enable32Bit = lib.mkDefault true;
  };

  hardware.amdgpu.initrd.enable = lib.mkDefault true;

  systemd.tmpfiles.rules = let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        rocblas
        hipblas
        clr
      ];
    };
  in [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
  ];

  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    amdvlk
    driversi686Linux.amdvlk
  ];

  environment.systemPackages = with pkgs; [lact clinfo];
  systemd.packages = with pkgs; [lact];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
