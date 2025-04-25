{ pkgs, lib, config, ... }:
{
  # Declare the custom option
  options = {
    stowModules = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "List of directories to stow";
    };
  };

  config = {
    home.packages = with pkgs; [
      stow
    ];

    # Move stowModules inside config
    stowModules = [
      "yazi"
      "wezterm"
      "sesh"
      "stu"
      # "hypr"
    ];

    # TODO:
    # - use nix system activation instead of home manager
    # - use ln instead of stow?
    home.activation =
      let
        dotfilesDir = "${config.home.homeDirectory}/nix-config/dotfiles";
      in
      {
        dotfileSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          if [ -d "${dotfilesDir}" ]; then
            pushd "${dotfilesDir}"
            ${pkgs.stow}/bin/stow -vt $HOME/.config --ignore=\.nix ${lib.concatStringsSep " " config.stowModules}
            popd
          else
            echo "Dotfiles directory not found: ${dotfilesDir}"
          fi
        '';

        createNotesSymlink = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          if [ "$(uname)" = "Linux" ] && [ -d /Users/arar/notes ] && [ -d /home/arar ]; then
            if [ ! -e /home/arar/notes ]; then
              ln -s /Users/arar/notes /home/arar/notes
            fi
          fi
        '';
      };
  };
}


# { inputs, lib, config, pkgs, ... }:
# {
#   home.packages = with pkgs; [
#     stow
#   ];
#
#   # see https://github.com/arminveres/nix-conf/blob/3185d4f86b9ea13da518a9c6112115340cfdbdc1/modules/home/default.nix#L109
#   home.activation = {
#     dotfileSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
#                   pushd "$HOME/nix-config/dotfiles"
#                   ${pkgs.stow}/bin/stow -vt $HOME/.config \
#             	  nvim \
#             	  scripts \
#             	  yazi \
#             	  lazygit \
#       		      oatmeal
#                   popd
#     '';
#   };
# }
#

