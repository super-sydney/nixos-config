{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.vlc.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable VLC.";
  };

  config = lib.mkIf config.vlc.enable {
    home.packages = with pkgs; [ vlc ];
  };
}
