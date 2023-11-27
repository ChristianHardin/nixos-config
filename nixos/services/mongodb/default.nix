{ pkgs, ... }:
{
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb;
    bind_ip = "127.0.0.1";
  };
}