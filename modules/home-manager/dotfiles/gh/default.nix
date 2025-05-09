{ inputs, pkgs, lib, config, ... }:
{
  programs.gh = {
    enable = true;

    settings.aliases = {
      co = "pr checkout";
    };

    extensions = [
      pkgs.gh-dash
      pkgs.gh-cal
    ];
  };

  # programs.gh-dash.enable = true;
}
