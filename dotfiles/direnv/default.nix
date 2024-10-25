{ inputs, lib, config, pkgs, ... }:
{
  home.file = {
    # ".config/direnv".source = ./direnv;
    ".config/direnv/direnvrc".source = ./direnv/direnvrc;
    ".config/direnv/direnv.toml".source = ./direnv/direnv.toml;

  };
}
