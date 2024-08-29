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
    # useGlobalPkgs = true; 
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = { inherit inputs; }; # allows access to flake inputs in hm modules
    users.arar = { config, pkgs, ... }: {
      home.homeDirectory = lib.mkForce "/Users/arar";
      imports = [
        inputs.nix-index-database.hmModules.nix-index
        inputs.agenix.homeManagerModules.default

        ../../users/arar/dotfiles.nix
        ../../users/arar/age.nix
        # ./arar/system.nix
      ];

      home.packages = with pkgs; [
        # neovim # Neovim package
        # Add more packages here if needed
      ];

      # Optionally, configure Neovim
      programs.neovim = {
        enable = true;
        # Set custom Neovim settings here, for example:
        # vimAlias = true; # If you want to use 'vim' command to open Neovim
        # Configure additional plugins if needed
      };

      # home.file = {
      # ".config/zsh/initExtra".source = ../../dotfiles/zsh/initExtra;
      # ".config/nvim".source = ../../dotfiles/nvim;
      # ".config/wezterm".source = ../../dotfiles/wezterm;
      # };
    };
  };

  nix.settings.max-jobs = "auto";
}

