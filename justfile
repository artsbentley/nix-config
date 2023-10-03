# justfile

# Update the Git repository and rebuild NixOS with the specified flake
nix:
    git pull
    sudo nixos-rebuild switch --flake '.#arar'

# Update the Git repository and switch Home Manager to the specified flake
home:
    git pull
    home-manager switch --flake '.#arar@nixos'

