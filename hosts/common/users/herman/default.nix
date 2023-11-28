{ pkgs, config, ... }:
{
  users.users.herman = {
    description = "Herman";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel" "networkmanager"];
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.herman = import ../../../../home/herman/${config.networking.hostName}.nix;
}