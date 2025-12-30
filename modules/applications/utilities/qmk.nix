{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.qmk.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable QMK and VIA keyboard firmware tools.";
  };

  config = lib.mkIf config.qmk.enable {
    home.packages = with pkgs; [
      qmk
      via
      qmk-udev-rules
    ];
  };
}
