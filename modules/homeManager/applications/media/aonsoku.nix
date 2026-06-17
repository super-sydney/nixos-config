{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.aonsoku.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Aonsoku Music Player";
  };

  config = lib.mkIf config.aonsoku.enable {
    home.packages = with pkgs; [ aonsoku ];
  };
}
