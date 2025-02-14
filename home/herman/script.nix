{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''
  set -e
  pushd /etc/nixos/
  nvim flake.nix
  alejandra . &>/dev/null
  git diff -U0 *.nix
  echo "NixOS Rebuilding..."
  sudo nixos-rebuild switch &>nixos-switch.log ||
  	(cat nixos-switch.log | grep --color error && false)
  gen=$(nixos-rebuild list-generations | grep current)
  home-manager --flake .#herman@oracle switch
  git commit -S -am "$gen"
  popd
''
