{ vars, config, ... }:
{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings = {
      server = {
        bind_address = "::1";
        # bind_address = "0.0.0.0";
        secret_key = "mysecret";
      };
    };
  };
}
