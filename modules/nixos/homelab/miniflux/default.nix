{ config
, lib
, ...
}:
{
  services.miniflux = {
    enable = true;
    adminCredentialsFile = config.age.secrets.minifluxAdminPassword.path;
    config = {
      CREATE_ADMIN = "1";
      LISTEN_ADDR = "127.0.0.1:8067";
    };
  };
  networking.firewall.allowedTCPPorts = [ 8060 ];
}
