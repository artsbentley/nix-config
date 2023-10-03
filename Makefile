nixos:
    git pull && sudo nixos-rebuild switch --flake '.#arar'

home:
    home-manager switch --flake '.#arar@nixos'

