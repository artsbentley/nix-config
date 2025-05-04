{ config
, lib
, ...
}:
{
  services.miniflux = {
    enable = true;
    adminCredentialsFile = config.age.secrets.minifluxAdminPassword.path;
    config = {
      LISTEN_ADDR = "127.0.0.1:8060";
    };
  };
  networking.firewall.allowedTCPPorts = [ 8060 ];
}
