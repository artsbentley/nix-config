# justfile

# Update the Git repository and rebuild NixOS with the specified flake
update-nixos:
    git pull
    sudo nixos-rebuild switch --flake '.#arar'

# Update the Git repository and switch Home Manager to the specified flake
update-home:
    git pull
    home-manager switch --flake '.#arar@nixos'

