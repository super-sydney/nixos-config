{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Networking
  networking.hostName = "laptop-sydney";
  networking.networkmanager.enable = true;
}
