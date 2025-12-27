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

  # Bootloader settings
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # NixOS Modules
  fish = {
    enable = true;
    users = [ "sydney" ];
  };
  flatpak.enable = true;
  steam.enable = true;
  virtualisation.enable = true;

  system.stateVersion = "25.05";

}
