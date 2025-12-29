{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.osuLazer.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable osu!lazer AppImage package.";
  };

  config = lib.mkIf config.osuLazer.enable {
    # osu-lazer doesn't have online capabilities, so this is the AppImage version
    home.packages = with pkgs; [ osu-lazer-bin ];
  };
}
