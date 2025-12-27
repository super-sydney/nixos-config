{ pkgs, lib, config, ... }:

{
  options.qbittorrent.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable qBittorrent.";
  };

  config = lib.mkIf config.qbittorrent.enable {
    home.packages = with pkgs; [ qbittorrent ];
  };
}
