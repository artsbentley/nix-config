{ vars, ... }:
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
  services = {
    syncthing = {
      enable = true;
      user = "arar";
      # group = "share";
      guiAddress = "0.0.0.0:8384";
      overrideFolders = false;
      overrideDevices = false;
      dataDir = "${vars.nasMount}/Syncthing";
      configDir = "${vars.serviceConfigRoot}/syncthing";
      settings = {
        folders = {
          "Downloads" = {
            path = "${vars.nasMount}/Syncthing/Downloads";
          };
          "root-syncthing" = {
            path = "${vars.nasMount}/Syncthing";
          };
          "banana" = {
            path = "${vars.nasMount}/Syncthing/banana";
          };
        };
      };
    };
  };
}

