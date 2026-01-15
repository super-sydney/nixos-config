{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.opentabletdriver.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable OpenTabletDriver.";
  };

  config = lib.mkIf config.opentabletdriver.enable {
    hardware.opentabletdriver.enable = true;
    boot.kernelModules = [ "uinput" ];

    environment.systemPackages = with pkgs; [ opentabletdriver ];
  };
}
