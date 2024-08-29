{ inputs, pkgs, lib, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  imports = [ <home-manager/nix-darwin> ];
  home-manager = {
    useGlobalPkgs = false; # makes hm use nixos's pkgs value
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; }; # allows access to flake inputs in hm modules
    users.arar = { config, pkgs, ... }: {
      # nixpkgs.overlays = [
      #   inputs.nur.overlay
      # ];
      home.homeDirectory = lib.mkForce "/Users/arar";

      # home.stateVersion = "23.11";
      home.file = {
        # ".config/zsh/initExtra".source = ../../dotfiles/zsh/initExtra;
        # ".config/nvim".source = ../../dotfiles/nvim;
        # ".config/wezterm".source = ../../dotfiles/wezterm;
      };

      # NOTE: 
      # zsh and nvim are taken care of in nix server config, no need to
      # import here
      imports = [
        inputs.nix-index-database.hmModules.nix-index
        inputs.agenix.homeManagerModules.default
        ../../users/arar/dotfiles.nix
        ../../users/arar/age.nix
        # TODO: 
        # import other modules
        # ../../dotfiles/tmux
      ];
    };

    backupFileExtension = "bak";
  };

  nix.settings.max-jobs = "auto";
}

