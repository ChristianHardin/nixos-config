{
  config,
  lib,
  pkgs,
  ...
}: let
  grep = pkgs.gnugrep;

  # 1. Declare the Flatpaks you *want* on your system
  desiredFlatpaks = [
    "org.mozilla.firefox"
    "com.valvesoftware.Steam"
    "org.freedesktop.Platform.VulkanLayer.gamescope//24.08"
    "org.freedesktop.Platform.VulkanLayer.vkBasalt//24.08"
    "org.freedesktop.Platform.VulkanLayer.MangoHud//24.08"
    "com.obsproject.Studio.Plugin.OBSVkCapture"
    "com.obsproject.Studio"
    "org.videolan.VLC"
    "org.prismlauncher.PrismLauncher"
    "dev.vencord.Vesktop"
    "com.heroicgameslauncher.hgl"
    "org.libreoffice.LibreOffice"
    "com.github.Matoking.protontricks"
    "org.gimp.GIMP"
    "org.kde.okular"
  ];
in {
  options = {
    flatpak.enable =
      lib.mkEnableOption "enables flatpak";
  };

  # imports = [./steam-devices.nix];
  config = lib.mkIf config.flatpak.enable {
    services.flatpak.enable = true;
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
    xdg.portal.xdgOpenUsePortal = true;

    system.activationScripts.flatpakManagement = {
      text = ''
        # 2. Ensure the Flathub repo is added
        ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub \
          https://flathub.org/repo/flathub.flatpakrepo

        # 3. Get currently installed Flatpaks
        installedFlatpaks=$(${pkgs.flatpak}/bin/flatpak list --app --columns=application)

        # 4. Remove any Flatpaks that are NOT in the desired list
        #for installed in $installedFlatpaks; do
        #  if ! echo ${toString desiredFlatpaks} | ${grep}/bin/grep -q $installed; then
        #    echo "Removing $installed because it's not in the desiredFlatpaks list."
        #    ${pkgs.flatpak}/bin/flatpak uninstall -y --noninteractive $installed
        #  fi
        #done

        # 5. Install or re-install the Flatpaks you DO want
        for app in ${toString desiredFlatpaks}; do
          echo "Ensuring $app is installed."
          ${pkgs.flatpak}/bin/flatpak install -y flathub $app
        done

        # 6. Update all installed Flatpaks
        ${pkgs.flatpak}/bin/flatpak update -y
      '';
    };
  };
}
