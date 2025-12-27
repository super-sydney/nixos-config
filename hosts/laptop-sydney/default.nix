{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ./localisation.nix
      ./network.nix
      ./services.nix
      ./users.nix
    ];

  # Enable flakes & nix command for this configuration
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader settings (moved from network.nix for clarity)
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # NixOS Modules
  # flatpak.enable = true;
  # steam.enable = true;
  # virtualisation.enable = true;

  system.stateVersion = "25.05";

}
