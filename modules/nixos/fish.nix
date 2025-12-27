{ config, lib, pkgs, ... }:

let
  cfg = config.fish;
  mkUserShell = user: { users.users.${user}.shell = pkgs.fish; };
  shellsForUsers = map mkUserShell cfg.users;
  mergedUserShells = lib.mkMerge shellsForUsers;

in {
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

  config = lib.mkIf cfg.enable ({
    programs.fish.enable = true;
  } // mergedUserShells);
}
