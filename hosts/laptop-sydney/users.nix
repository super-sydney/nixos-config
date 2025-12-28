{ config, pkgs, lib, ... }:

{
  users.users.sydney =
    {
      isNormalUser = true;
      description = "Sydney";
      extraGroups = [ "networkmanager" "wheel" ];
    }
    // (lib.optionalAttrs config.fish.enable {
      shell = pkgs.fish;
    });
}
