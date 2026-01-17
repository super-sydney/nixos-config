{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gimp.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable GIMP.";
  };

  config = lib.mkIf config.gimp.enable {
    home.packages = with pkgs; [ gimp ];
  };
}
