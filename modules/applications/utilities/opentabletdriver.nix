{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.opentabletdriver.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable OpenTabletDriver.";
  };

  config = lib.mkIf config.opentabletdriver.enable {
    home.packages = with pkgs; [ opentabletdriver ];
  };
}
