{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.syncthing.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable syncthing";
  };

  config = lib.mkIf config.syncthing.enable {
    services.syncthing = {
      enable = true;
      group = "users";
      user = "sydney"; # Default "syncthing" user has different permissions
      dataDir = "/home/sydney";
      configDir = "/home/sydney/.config/syncthing";
      openDefaultPorts = true;
    };
  };
}
