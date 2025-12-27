{ config, pkgs, ... }:

{
  # Networking
  networking.hostName = "laptop-sydney";
  networking.networkmanager.enable = true;
}
