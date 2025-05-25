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
        port = 8888;
        secret_key = "mysecret";
      };
    };
  };
}


