{pkgs}:
pkgs.writeShellScriptBin "rebuild-home" ''
  set -e
  pushd /etc/nixos/
  nvim ./home/herman/oracle.nix
  alejandra . &>/dev/null
  git diff -U0 *.nix
  gen=$(nixos-rebuild list-generations | grep current)
  echo "Home Rebuilding..."
  home-manager --flake .#herman@oracle switch &>home-switch.log ||
  	(cat home-switch.log | grep --color error && false)
  git commit -S -am "$gen"
  popd
''
