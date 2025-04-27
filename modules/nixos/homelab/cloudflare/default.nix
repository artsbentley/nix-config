{ config, vars, ... }:
{
  virtualisation.oci-containers = {
    containers = {
      cloudflaretunnel = {
        image = "cloudflare/cloudflared:latest";
        autoStart = true;
        environmentFiles = [ config.age.secrets.cloudflareTunnel.path ];
        environment = { };
        cmd = [
          "tunnel"
          "--no-autoupdate"
          "run"
        ];
      };
    };
  };
}


