function update() {
    git pull
    
    if [[ "$(uname)" == "Darwin" ]]; then
        nix build .#darwinConfigurations.arar.system --show-trace --impure
        ./result/sw/bin/darwin-rebuild switch --flake "$(pwd)#arar"

    else
        sudo nixos-rebuild switch --flake .#arar
    fi
}

