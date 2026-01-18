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
    shell = if config.programs.fish.enable then "${pkgs.fish}/bin/fish" else "${pkgs.bash}/bin/bash";
  };
}
