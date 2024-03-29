{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware.url = "github:nixos/nixos-hardware";
    # nixarr.url = "github:rasmus-kirk/nixarr";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in

    {
      nixosConfigurations = {
        arar = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = [
            # nixarr.nixosModules.default
            ./nixos/homelab/default.nix
            ./hardware-configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "arar@nixos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = [ ./home-manager/home.nix ];
        };
      };
    };
}

