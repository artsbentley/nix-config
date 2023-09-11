# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
	./zsh
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
    git
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

# git
  programs.git = {
    enable = true;
    userName = "artsbentley";
    userEmail = "artsbentley@gmail.com";

    aliases = {
      s = "status";
    };
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "GitHub";
    };
  };


  };


# programs.zsh = {
#   enable = true;
#   #dotDir = ".config/zsh";
#   shellAliases = {
#     "vim" = "nvim";
#     "v" = "nvim";
#     ":GoToFile" = "nvim +GoToFile";
#
#
#     ".." = "cd ..";
#     "c" = "clear";
#     "l" = "exa -lbF -l --icons -a --git";
#     "update" = "cd ~/nix-config && sudo nixos-rebuild switch --flake .#arar";
#   };
#   #histSize = 10000;
#   #histFile = "${config.xdg.dataHome}/zsh/history";
# };

programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

programs.bat = {
    enable = true;
    config = {
      theme = "GitHub";
      italic-text = "always";
    };
  };

  programs.starship = {
    enable = true;
  };

  # configure environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file = {

  };

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
