{ config, pkgs, ... }:

{
  users.users.sydney = {
    isNormalUser = true;
    description = "Sydney";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
