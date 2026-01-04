{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.piper.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Piper.";
  };

  config = lib.mkIf config.piper.enable {
    home.packages = with pkgs; [ piper ];
  };
}
