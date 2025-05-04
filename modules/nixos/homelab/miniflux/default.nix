{ config
, lib
, ...
}:
{
  services.miniflux = {
    enable = true;
    adminCredentialsFile = config.age.secrets.minifluxAdminPassword.path;
    config = {
      LISTEN_ADDR = "localhost:8060";
    };
  };
  networking.firewall.allowedTCPPorts = [ 8060 ];
}
