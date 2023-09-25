{ user
, pkgs
, lib
, config
, ...
}: {
  imports = [
    ./starship
    ./git
    ./shell
  ];
}

