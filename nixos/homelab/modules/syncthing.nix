{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "arar";
    dataDir = "/home/arar/syncthing"; # Default folder for new synced folders
    configDir = "/home/arar/syncthing/.config/syncthing"; # Folder for Syncthing's settings and keys
    guiAddress = "0.0.0.0:8384";
    openDefaultPorts = true;
  };
  networking.firewall.allowedTCPPorts = [ 8384 22000 80 443 8222 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];


  # modules.services.vaultwarden.enable = true;
  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    config = {
      DOMAIN = "https://vault.flake.sh/";
      SIGNUPS_ALLOWED = true;
      # DATABASE_URL = "postgresql://vaultwarden:vaultwarden@192.168.1.211:5432/vaultwarden";
      LOG_LEVEL = "Info";
      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";
    };
  };
}
