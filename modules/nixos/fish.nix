{ config, lib, pkgs, ... }:

{
  options.fish = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Fish shell system-wide and configure selected user shells.";
    };

    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Users whose login shell will be set to fish when enabled.";
    };
  };

  config = lib.mkIf config.fish.enable (
    let
      mkUserShell = user: { users.users.${user}.shell = pkgs.fish; };
      shellsForUsers = map mkUserShell config.fish.users;
    in
    {
      programs.fish.enable = true;
    } // lib.mkMerge shellsForUsers
  );
}
