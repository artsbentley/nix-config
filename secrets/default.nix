{ modulesPath, lib, config, pkgs, ... }:

{
  age = {
    secrets = {
      test.file = ./test.age;
      protonVpnUser.file = ./protonVpnUser.age;
      protonVpnPass.file = ./protonVpnPass.age;
    };
  };
}


