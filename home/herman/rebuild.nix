{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''
   set -e
  HOSTNAME=$(hostname)

   Help()
   {
   	# Display Help
   	echo "Usage: [OPTION]"
   	echo "Script to handle Nixos System and Home-manager rebuilding."
   	echo
   	echo "	-h 				display this help and exit"
   	echo "	-s				rebuild Nixos"
   	echo "	-u 				rebuild Home"
   	echo "	-a 				rebuild Nixos and Home"
   }

   RebuildNixos()
   {
   	pushd /etc/nixos/
   	git diff -U0 *.nix

   	echo "NixosOs Rebuilding..."
   	sudo nixos-rebuild switch &>nixos-switch.log ||
   		(cat nixos-switch.log | grep --color error && false)
   	gen=$(nixos-rebuild list-generations | grep current)
   	if type "alejandra" >/dev/null 2>&1
   	then
   		echo "Formatting ..."
   		alejandra --quiet .
   	else
   		echo "Alejandra not found. Skipping..."
   	fi

   	git commit -S -am "$gen" &> /dev/null
   	popd
   }

   RebuildHome()
   {
   	pushd /etc/nixos/
   	git diff -U0 *.nix

   	echo "Home Rebuilding ..."
   	home-manager --flake .#$USER@$HOSTNAME switch &>home-switch.log ||
   		(cat home-switch.log | grep --color error && false)
   	gen=$(nixos-rebuild list-generations | grep current)

   	if type "alejandra" >/dev/null 2>&1
   	then
   		echo "Formatting ..."
   		alejandra --quiet .
   	else
   		echo "Alejandra not found. Skipping..."
   	fi

   	git commit -S -am "$gen" &> /dev/null
   	popd
   }

   RebuildAll()
   {
   	pushd /etc/nixos/
   	git diff -U0 *.nix

   	echo "NixosOs Rebuilding..."
   	sudo nixos-rebuild switch &>nixos-switch.log ||
   		(cat nixos-switch.log | grep --color error && false)
   	echo "Home Rebuilding ..."
   	home-manager --flake .#$USER@$HOSTNAME switch &>home-switch.log ||
   		(cat home-switch.log | grep --color error && false)
   	gen=$(nixos-rebuild list-generations | grep current)

   	if type "alejandra" >/dev/null 2>&1
   	then
   		echo "Formatting ..."
   		alejandra --quiet .
   	else
   		echo "Alejandra not found. Skipping..."
   	fi

   	git commit -S -am "$gen" &> /dev/null
   	popd
   }

   while getopts ":hsua" option; do
   	case $option in
   		h) # display Help
   			Help
   			exit;;
   		s) # rebuild Nixos
   			RebuildNixos
   			exit;;
   		u) # rebuild Home
   			RebuildHome
   			exit;;
   		a)
   			echo "hit"
   			RebuildAll
   			exit;;
   		\?) # Invalid
   			echo "Error: Invalid Option"
   			exit;;
   	esac
   done
''
