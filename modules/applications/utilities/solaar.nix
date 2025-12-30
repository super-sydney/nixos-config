{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.solaar.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Solaar for Logitech Unifying/Lightspeed devices.";
  };

  config = lib.mkIf config.solaar.enable {
    home.packages = with pkgs; [ solaar ];
  };
}
