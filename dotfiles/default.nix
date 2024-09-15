{ inputs, lib, config, pkgs, ... }:
{
  programs.zsh.initExtra = ''
            path=("$HOME/.config/scripts" $path)
    		'';
}




