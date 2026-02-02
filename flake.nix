{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    dw-proton.url = "github:Momoyaan/dwproton-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      zen-browser,
      dw-proton,
      ...
    }@inputs:
    {

      # Define multiple NixOS configurations keyed by host name.
      nixosConfigurations = {
        "laptop-sydney" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/laptop-sydney # Host configuration
            ./modules/nixos # System modules
            {
              nixpkgs.hostPlatform = "x86_64-linux";
              nixpkgs.config.allowUnfree = true; # Allow installation of unfree packages

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.sydney = import ./hosts/laptop-sydney/home.nix;
            }
          ];
        };
      };
    };
}
