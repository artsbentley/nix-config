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

        # ADD NON-NIXOS/ SERVER PACKAGES HERE
        ../../users/arar/dotfiles.nix
        ../../users/arar/age.nix
        ../../dotfiles/tmux
        ../../dotfiles/wezterm
        ../../dotfiles/aerospace
        ../../dotfiles/raycast
        ../../dotfiles/nvim
        # ../../dotfiles/direnv


        # TODO:
        # direnv
        # dive
      ];
    };
  };

  nix.settings.max-jobs = "auto";
}

