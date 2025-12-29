{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.steam.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Steam.";
  };

  config = lib.mkIf config.steam.enable {
    programs.steam.enable = true;
  };
}
