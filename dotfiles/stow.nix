{ inputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    stow
  ];

  home.activation = {
    dotfileSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      os=$(uname)
      if [ "$os" = "Darwin" ]; then
        home_dir="/Users/$(whoami)"
      else
        home_dir="/home/$(whoami)"
      fi

      pushd $home_dir/nix-config/dotfiles
      ${pkgs.stow}/bin/stow -vt $home_dir/.config nvim scripts
      popd
    '';
  };
}



