{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  umu = inputs.umu.packages.${system}.umu.override {
    version = inputs.umu.shortRev;
    truststore = true;
    cbor2 = true;
  };
in {
  options = {
    umu-launcher.enable =
      lib.mkEnableOption "enable umu-launcher";
  };

  config = lib.mkIf config.umu-launcher.enable {
    environment.systemPackages = [umu];
  };
}
