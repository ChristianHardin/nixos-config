{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    kdeconnect.enable =
      lib.mkEnableOption "enable kdeconnect";
  };

  config = lib.mkIf config.kdeconnect.enable {
    programs.kdeconnect.enable = true;

    networking.firewall = rec {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
