{ inputs, lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    stow
  ];

  # home.file = {
  #   ".config/nvim".source = ./nvim;
  # };

  home.activation = {
    dotfileSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # Detect the OS (Darwin or Linux)
      os=$(uname)
      if [ "$os" = "Darwin" ]; then
        home_dir="/Users/arar"
      else
        home_dir="/home/arar"
      fi

      # Change to dotfiles directory
      pushd home/arar/nix-config/dotfiles

      # Symlink only 'nvim' into the .config directory
      ${pkgs.stow}/bin/stow -vt $(home_dir)/.config nvim

      # Return to the previous directory
      popd
    '';
  };

}


