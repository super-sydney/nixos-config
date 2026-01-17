{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.calibre.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Calibre.";
  };

  config = lib.mkIf config.calibre.enable {
    home.packages = with pkgs; [ calibre ];
  };
}
