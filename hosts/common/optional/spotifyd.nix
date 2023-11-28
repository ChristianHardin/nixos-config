{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    spotifyd
    spotify-tui # optional
  ];

  systemd.user.services.spotifyd = {
    description = "A spotify playing daemon";
    wants = [
      "sound.target"
      "network-online.target"
    ];
    after = [
      "sound.target"
      "network-online.target"
    ];
    serviceConfig = {
      ExecStart = "${pkgs.spotifyd}/bin/spotifyd --no-daemon";
      Restart = "always";
      RestartSec = 12;
    };

    wantedBy= [ "default.target" ];
  };
}