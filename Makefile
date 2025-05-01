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

homelab:
	git pull --autostash
	# cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
	sudo nixos-rebuild switch --flake '.#homelab' --show-trace

orbstack:
	git pull --autostash
	# cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
	sudo nixos-rebuild switch --flake '.#orbstack' --impure --show-trace

surface:
	git pull --autostash
	# cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
	sudo nixos-rebuild switch --flake '.#surface'  --impure

kpn:
	git pull --autostash
	nix build .#darwinConfigurations.kpn.system --show-trace --impure  
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#kpn" --impure 

mac:
	git pull --autostash
	nix build .#darwinConfigurations.arar.system --show-trace --impure  
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#arar" --impure 

home:
	git pull
	home-manager switch --flake '.#arar@nixos'

setup:
	sudo sed -i '/^};/i\  nix.experimental-features = [ "nix-command" "flakes" ];' /etc/nixos/configuration.nix
	cp /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
	# sudo nixos-generate-config
	sudo nixos-rebuild switch

compose:
	sudo docker-compose -f docker/docker-compose.yml down
	git pull
	sudo docker-compose -f docker/docker-compose.yml up -d

logs:
	sudo journalctl -xeu systemd-tmpfiles-resetup

mount:
	sudo mount -t nfs 192.168.2.11:/mnt/nas/server /mnt/nas

