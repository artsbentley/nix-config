function update() {
    # Navigate to the nix-config directory
    cd ~/nix-config
    
    # Pull the latest changes from the git repository
    git pull
    
    # Check the operating system
    if [[ "$(uname)" == "Darwin" ]]; then
        # If the OS is Darwin (macOS), run the macOS-specific commands
        nix build .#darwinConfigurations.arar.system --show-trace --impure
        ./result/sw/bin/darwin-rebuild switch --flake "$(pwd)#arar"
    else
        # If the OS is Linux, run the Linux-specific command
        sudo nixos-rebuild switch --flake .#arar
    fi
    
    # Return to the previous directory
    cd -
}

