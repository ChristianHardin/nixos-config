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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFNN3wdKSwzvtVE2Y4My3UI5KgNrJnU6GVz0kJ+m7WgX christianhardin12345@gmail.com"
    ];
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.herman = import ../../../../home/herman/${config.networking.hostName}.nix;
}