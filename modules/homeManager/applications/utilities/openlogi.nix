{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.openlogi.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable OpenLogi.";
  };

  config = lib.mkIf config.openlogi.enable {
    home.packages = with pkgs; [
      openlogi
    ];
  };
}
