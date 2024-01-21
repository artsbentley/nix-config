{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    ./shell
    # ./programs
  ];

  nixpkgs = {
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "arar";
    homeDirectory = "/home/arar";
  };

  #targets.genericLinux.enable = true; #ENABLE ON NON-LINUX

  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    gnumake
    just
    git
    curl
    ripgrep
    #zsh
    git-crypt
    gnupg
    vim
    neovim
    neofetch
    powertop
    zoxide
    starship
    exa
    rustc
    gcc
    cargo
  ];

  # configure environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file = { };

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
