{ config, pkgs, ... }: {
  system.activationScripts.myFile = ''
    echo "${config.age.secrets.openaiApiKey.path}" > /Users/arar/secret 
  '';
}
