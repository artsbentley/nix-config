{ inputs
, outputs
, lib
, config
, vars
, userConfig
, hostConfig
, pkgs
, ...
}:

# TODO: use hostConfig instead of "vars"
{
  fileSystems."/mnt/usbssd" = lib.mkIf hostConfig.isHomelab {
    device = "/dev/disk/by-uuid/6ea969c7-cde5-45c2-ac53-236704f93228";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  fileSystems."${vars.ararNasMount}" = {
    device = "//192.168.1.123/ararmount";
    fsType = "cifs";
    options =
      let automount_opts =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [
        "${automount_opts},credentials=${config.age.secrets.smbCredentials.path},uid=1010,gid=1010,file_mode=0775,dir_mode=0775"
      ];
  };

  fileSystems."${vars.homelabNasMount}" = {
    device =
      "//192.168.1.123/servermount";
    fsType = "cifs";
    options =
      let automount_opts =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [
        "${automount_opts},credentials=${config.age.secrets.smbCredentials.path},uid=1010,gid=1010,file_mode=0775,dir_mode=0775"
      ];
  };

  fileSystems."${vars.rootNasMount}" = {
    device = "//192.168.1.123/rootmount";
    fsType = "cifs";
    options =
      let automount_opts =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [
        "${automount_opts},credentials=${config.age.secrets.smbCredentials.path},uid=1010,gid=1010,file_mode=0775,dir_mode=0775"
      ];
  };
}
