{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Pin GNOME to a specific version (24.11 = GNOME 47)
    nixpkgs-gnome.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, nixpkgs-gnome, home-manager, nix-flatpak, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {inherit system; };
      moduleSets = import ./modules;
    in
    {

    # Define multiple NixOS configurations keyed by host name.
    nixosConfigurations = {
      "laptop-sydney" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.config.allowUnfree = true; }
          
          # Overlay to use stable GNOME packages
          {
            nixpkgs.overlays = [
              (final: prev: {
                gnome = nixpkgs-gnome.legacyPackages.${system}.gnome;
                gnomeExtensions = nixpkgs-gnome.legacyPackages.${system}.gnomeExtensions;
              })
            ];
          }
          
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
        ]
        ++ builtins.attrValues moduleSets.nixosModules
        ++ [
          ./hosts/laptop-sydney
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sydney = import ./hosts/laptop-sydney/home.nix;
          }
        ];
      };
    };
  };
}
