{
  inputs,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  umu = inputs.umu.packages.${system}.umu.override {
    version = inputs.umu.shortRev;
    truststore = true;
    cbor2 = true;
  };
in {
  environment.systemPackages = [umu];
}
