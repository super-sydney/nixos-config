{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ./localisation.nix
      ./network.nix
      ./services.nix
      ./users.nix
    ];

  # Enable flakes & nix command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Optimise store contents and enable automatic GC
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly"; # run gc weekly
    options = "--delete-older-than 7d"; # keep last 7 days of generations
  };

  # Bootloader settings
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # NixOS Modules
  fish.enable = true;
  flatpak.enable = true;
  steam.enable = true;
  virtualisation.enable = true;

  system.stateVersion = "25.05";

}
