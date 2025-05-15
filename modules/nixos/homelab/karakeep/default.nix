{ config, vars, ... }:
let
  directories = [
    "${vars.serviceConfigRoot}/karakeep"
  ];
in
{
  systemd.tmpfiles.rules = map (x: "d ${x} 0775 share share - -") directories;
  virtualisation.oci-containers = {
    containers = {
      karakeep-web = {
        image = "ghcr.io/karakeep-app/karakeep:release";
        pull = "newer";
        volumes = [ "${vars.serviceConfigRoot}/karakeep:/data" ];
        ports = [ "3111:3000" ];
        dependsOn = [
          "karakeep-chrome"
          "karakeep-meilisearch"
        ];
        environment = {
          MEILI_ADDR = "http://karakeep-meilisearch:7700";
          BROWSER_WEB_URL = "http://karakeep-chrome:9222";
          OPENAI_API_KEY = config.age.secrets.openaiApiKey.path;
          DATA_DIR = "/data";
        };
        environmentFiles = [ config.age.secrets.karakeep.path ];
      };


      karakeep-chrome = {
        image = "ghcr.io/zenika/alpine-chrome:latest";
        pull = "newer";
        cmd = [
          "--no-sandbox"
          "--disable-gpu"
          "--disable-dev-shm-usage"
          "--remote-debugging-address=0.0.0.0"
          "--remote-debugging-port=9222"
          "--hide-scrollbars"
        ];
      };

      karakeep-meilisearch = {
        image = "getmeili/meilisearch:latest";
        volumes = [ "meilisearch:/meili_data" ];
        environment = {
          MEILI_NO_ANALYTICS = "true";
        };
        environmentFiles = [ config.age.secrets.karakeep.path ];
      };
    };
  };
}









