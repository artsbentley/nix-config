{ inputs, pkgs, lib, config, ... }:
{
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      dialect = "uk";
      filter_mode_shell_up_key_binding = "session";
      # workspaces = true;
      invert = true;
      style = "compact";
      inline_height = 16;
      enter_accept = false;
      ctrl_n_shortcuts = true;
    };
  };
}

