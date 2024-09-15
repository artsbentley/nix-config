{ inputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    stow
  ];

  # see https://github.com/arminveres/nix-conf/blob/3185d4f86b9ea13da518a9c6112115340cfdbdc1/modules/home/default.nix#L109
  home.activation = {
    dotfileSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            # os=$(uname)
            # if [ "$os" = "Darwin" ]; then
            #   home_dir="/Users/$(whoami)"
            # else
            #   home_dir="/home/$(whoami)"
            # fi
      	  # home_dir="$HOME/$(whoami)"
            pushd "$HOME/nix-config/dotfiles"
            ${pkgs.stow}/bin/stow -vt $HOME/.config nvim scripts yazi
            popd
    '';
  };
}



