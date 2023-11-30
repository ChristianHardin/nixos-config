{ pkgs, config, ... }:
let 
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.herman = {
    description = "Herman";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" 
    ] ++ ifTheyExist [ 
      "docker"
      "networkmanager"
      "libvirtd"
      "docker"
      "podman"
      "git"
    ];
    openssh.authorizedKeys.keys = [
      # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
    ];
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.herman = import ../../../../home/herman/${config.networking.hostName}.nix;
}