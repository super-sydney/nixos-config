{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration
  ];

  # Nix settings
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # System modules (from /modules/nixos)
  hardware.keyboard.qmk.enable = true;
  nautilusOpenAnyTerminal.enable = true;
  nvtop.enable = true;
  opentabletdriver.enable = true;
  steam.enable = true;
  virtualisation.enable = true;

  system.stateVersion = "25.05";

}
