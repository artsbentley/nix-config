{ inputs, userConfig, nhModules, ... }: {
  imports = [
    "${nhModules}/common"
  ];

  _module.args.inputs = inputs; # This makes `inputs` available in config

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}

