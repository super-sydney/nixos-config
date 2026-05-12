{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.freetube.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable FreeTube.";
  };

  config = lib.mkIf config.freetube.enable {
    home.packages = with pkgs; [ freetube ];
  };
}
