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
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
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
          home-manager.nixosModules.home-manager
        ]
        ++ builtins.attrValues moduleSets.nixosModules
        ++ [
          ./hosts/laptop-sydney
          {
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
