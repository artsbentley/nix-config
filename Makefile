nixos:
	git pull
	sudo nixos-rebuild switch --flake '.#arar'

home:
	git pull
	home-manager switch --flake '.#arar@nixos'



