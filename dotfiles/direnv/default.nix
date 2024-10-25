{ inputs, lib, config, pkgs, ... }:
{
  home.file = {
    ".config/direnv".source = .config/direnv;
    # ".config/direnv/direnvrc".source = ./direnv;
    # ".config/direnv/direnv.toml".source = ./direnv/;

  };
}
