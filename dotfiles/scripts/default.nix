{ inputs, lib, config, pkgs, ... }:
{
  home.file = {
    ".config/scripts".source = ./scripts;
  };

  programs.zsh.initExtra = ''
            path=("$HOME/.config/scripts" $path)
    		'';
}

# {
#   home.file = {
#     ".local/bin" = {
#       source = ./scripts;
#       recursive = true;
#     };
#   };
# let
#   binPath = "${config.home.homeDirectory}/.local/bin";
#   scriptsPath = "${config.home.homeDirectory}/dotfiles/modules/home/scripts";
# in
# {
#   home.file."${binPath}".source =
#     config.lib.file.mkOutOfStoreSymlink "${scriptsPath}";
#
#   programs.zsh.initExtra = ''
#     if [ -d "$HOME/.local/bin" ]; then
#       export PATH="${binPath}:$PATH"
#     fi
#   '';
