{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.jellyfinMediaPlayer.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Jellyfin Media Player.";
  };

  config = lib.mkIf config.jellyfinMediaPlayer.enable {
    home.packages = with pkgs; [ jellyfin-media-player ];
  };
}
