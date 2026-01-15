{
  config,
  pkgs,
  lib,
  ...
}:

{
  users.users.sydney = {
    isNormalUser = true;
    description = "Sydney";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
