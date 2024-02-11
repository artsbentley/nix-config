{ config, pkgs, ... }:

{
  services = {
    syncthing = {
      enable = true;
      user = "arar";
      dataDir = "/home/arar/Documents"; # Default folder for new synced folders
      configDir = "/home/arar/Documents/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
  };
}
