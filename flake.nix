{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix = {
    #   url = "github:nix-community/stylix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # catppuccin.url = "github:catppuccin/nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {inherit system; };
      moduleSets = import ./modules;
    in
    {
    # Define multiple NixOS configurations keyed by host name.
    # Example usage:
    #  - build or switch the laptop: `nixos-rebuild switch --flake .#laptop-sydney`
    #  - later add a Raspberry Pi host under `hosts/raspberry-pi` and uncomment the example below.
    nixosConfigurations = {
      "laptop-sydney" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.config.allowUnfree = true; }
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

      # Example for a Raspberry Pi (aarch64). Create `hosts/raspberry-pi/configuration.nix`
      # and uncomment this block when ready.
      # "raspberry-pi" = nixpkgs.lib.nixosSystem {
      #   system = "aarch64-linux";
      #   specialArgs = { inherit inputs; };
      #   modules = [
      #     ./hosts/raspberry-pi/configuration.nix
      #     # inputs.home-manager.nixosModules.default
      #   ];
      # };
    };
  };
}
