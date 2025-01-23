{ vars, config, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/syncthing"
  ];
in
# TODO: decide if "share" user makes sense here or is "arar" would be better.
  # how would the interaction work for devices that arent the general server?
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 arar share - -") directories;
  networking.firewall = {
    allowedTCPPorts = [ 8384 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };
  # systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
  services = {
    syncthing = {
      enable = true;
      user = "arar";
      guiAddress = "0.0.0.0:8384";
      # overrideFolders = true;
      # overrideDevices = true;
      overrideFolders = false;
      overrideDevices = false;
      dataDir = "${vars.nasMount}/Syncthing";
      configDir = "${vars.serviceConfigRoot}/syncthing";
      settings = {
        gui = {
          user = "arar";
          password = "pass";
        };
        folders = {
          # "Downloads" = {
          #   path = "${vars.nasMount}/Syncthing/Downloads";
          #   devices = [ "arar-mac" ];
          # };
          # "root-syncthing" = {
          #   path = "${vars.nasMount}/Syncthing";
          #   devices = [ "arar-iphone" ];
          # };
          "notes" = {
            path = "${vars.nasMount}/Syncthing/notes";
            # devices = [ "arar-iphone" "arar-mac" ];
            ignorePerms = true;
          };
        };
      };
    };
  };
}

