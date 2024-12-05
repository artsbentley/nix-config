{
  inputs = {
    # secrets = {
    #   url = "git+file:secrets"; # the submodule is in the ./subproject dir
    #   flake = false;
    # };
    # nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      # url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    recyclarr-configs = {
      url = "github:recyclarr/config-templates";
      flake = false;
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nur.url = "github:nix-community/nur";
    zen-browser.url = "github:heywoodlh/flakes/main?dir=zen-browser";


  };

  outputs =
    { self
    , nixpkgs
    , nix-darwin
    , home-manager
    , recyclarr-configs
    , nixvim
    , nix-index-database
    , agenix
    , nur
    , zen-browser
    , ...
    }@inputs:
    {
      darwinConfigurations."arar" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          agenix.darwinModules.default
          ./machines/darwin
          ./machines/darwin/arar
          # ./machines/darwin/arar/system.nix
        ];
      };

      nixosConfigurations = {
        surface = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            vars = import ./machines/surface-nixos/vars.nix;
          };
          modules = [
            # surface specific
            # ./machines/surface-nixos/surface-pkgs

            # Base configuration and modules
            ./modules/podman
            ./modules/tailscale

            # Import the machine config + secrets
            ./machines/surface-nixos
            ./machines/surface-nixos/arar
            ./machines/surface-nixos/arar/hardware
            ./secrets
            agenix.nixosModules.default

            # Services and applications
            # ./containers/backrest

            # User-specific configurations
            ./users/arar
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.arar.imports = [
                agenix.homeManagerModules.default
                nix-index-database.hmModules.nix-index
                ./users/arar/dotfiles.nix
              ];
              home-manager.backupFileExtension = "bak";
            }
          ];
        };

        arar = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            vars = import ./machines/nixos/vars.nix;
          };
          modules = [
            # Base configuration and modules
            ./modules/podman
            ./modules/tailscale

            # Import the machine config + secrets
            ./machines/nixos
            ./machines/nixos/arar
            ./machines/nixos/arar/hardware
            ./machines/nixos/arar/backup
            ./machines/nixos/arar/syncthing
            ./secrets
            agenix.nixosModules.default

            # Services and applications
            # TODO: setup GPU acceleration for jellyfin, paperless and immich
            ./containers/arr
            ./containers/paperless
            ./containers/mealie
            ./containers/vaultwarden
            ./containers/cloudflare
            ./containers/homepage
            ./containers/actualbudget
            ./containers/gitea
            ./containers/stirling
            # ./containers/watchtower
            # ./containers/backrest

            # User-specific configurations
            ./users/arar
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = false;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.arar.imports = [
                agenix.homeManagerModules.default
                nix-index-database.hmModules.nix-index
                ./users/arar/dotfiles.nix
              ];
              home-manager.backupFileExtension = "bak";
            }
          ];
        };
      };
    };
}

