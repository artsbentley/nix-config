# nix:
# 	git pull
# 	sudo nixos-rebuild switch --flake '.#arar'
# 	home-manager switch --flake '.#arar@nixos'
#
# homelab:
# 	git pull
# 	sudo nixos-rebuild switch --flake '.#homelab'
# 	home-manager switch --flake '.#homelab@nixos'
#
# setup:
# 	echo 'nix.settings.experimental-features = [ "nix-command" "flakes" ];' | sudo tee -a /etc/nixos/configuration.nix > /dev/null
# 	cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
# 	nixos-rebuild switch
#
# personal:
# 	git pull
# 	sudo cp -f /etc/nixos/hardware-configuration.nix ./machines/hardware/vm-aarch64.nix
# 	sudo nixos-rebuild switch --flake '.#personal'

nix:
	git pull
	sudo nixos-rebuild switch --flake '.#arar'

home:
	git pull
	home-manager switch --flake '.#arar@nixos'

setup:
	sudo echo 'nix.experimental-features = [ "nix-command" "flakes" ];' | sudo tee -a /etc/nixos/configuration.nix > /dev/null
	# cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
	sudo nixos-generate-config
	sudo nixos-rebuild switch

