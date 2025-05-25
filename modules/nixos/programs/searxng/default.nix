{ vars, config, ... }:

# used for together with raycast quicklink:
# http://localhost:8888/search?q=!!%20{argument name="term"}

{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings = {
      server = {
        bind_address = "::1";
        # bind_address = "0.0.0.0";
        port = 8888;
        secret_key = "mysecret";
      };
    };
  };
}


