{ config, pkgs, ... }:

{
  services = {
    syncthing = {
      enable = true;
      user = "arar";
      dataDir = "/home/arar/syncthing"; # Default folder for new synced folders
      configDir = "/home/arar/syncthing/.config/syncthing"; # Folder for Syncthing's settings and keys
      guiAddress = "0.0.0.0:8384";
      openDefaultPorts = true;
    };
  };
  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

}
