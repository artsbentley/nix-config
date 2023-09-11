{ config, pkgs, lib, ... }:
with lib;
{
  programs.git = {
    enable = true;
    userName = "artsbentley";
    userEmail = "artsbentley@gmail.com";

    aliases = {
      s = "status";
    };
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "GitHub";
      };
    };
  };
}
