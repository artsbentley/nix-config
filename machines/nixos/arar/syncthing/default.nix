{ vars, config, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/syncthing"
  ];
in
# TODO: decide if "share" user makes sense here or is "arar" would be better.
  # how would the interaction work for devices that arent the general server?
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  networking.firewall = {
    allowedTCPPorts = [ 8384 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
  services = {
    syncthing = {
      enable = true;
      user = "arar";
      # group = "share";
      guiAddress = "0.0.0.0:8384";
      key = config.age.secrets.syncthingKey.path;
      cert = config.age.secrets.syncthingCert.path;
      overrideFolders = true;
      overrideDevices = true;
      dataDir = "${vars.nasMount}/Syncthing";
      configDir = "${vars.serviceConfigRoot}/syncthing";
      settings = {
        devices = {
          "arar-iphone" = { id = "HA2QVX3-UPFG5JT-TUYESKM-Z4XVNPW-CJQF6SX-GMXGOQ7-OPIPQBX-HMPHMAO"; };
        };
        folders = {
          "Downloads" = {
            path = "${vars.nasMount}/Syncthing/Downloads";
            devices = [ "arar-iphone" ];
          };
          # "root-syncthing" = {
          #   path = "${vars.nasMount}/Syncthing";
          #   devices = [ "arar-iphone" ];
          # };
          "obsidian" = {
            path = "${vars.nasMount}/Syncthing/obsidian";
            devices = [ "arar-iphone" ];
            ignorePerms = true;
          };
        };
      };
    };
  };
}

