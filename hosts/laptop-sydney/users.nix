{ config, pkgs, ... }:

{
  programs.fish.enable = true;
  users.users.sydney = {
    isNormalUser = true;
    description = "Sydney";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };
}
