nix:
	git pull
	sudo nixos-rebuild switch --flake '.#arar'

home:
	git pull
	home-manager switch --flake '.#arar@nixos'

setup:
	echo 'nix.settings.experimental-features = [ "nix-command" "flakes" ];' | sudo tee -a /etc/nixos/configuration.nix > /dev/null
	cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
	nixos-rebuild switch

