{
  config,
  lib,
  pkgs,
  ...
}:

let
  wallpaper = pkgs.fetchurl {
    url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/landscapes/shaded_landscape.png?raw=true";
    sha256 = "sha256-EZmkN1HxI00/uS7PYU+/NN4sBzNNP901WJEET1G92to=";
  };
in
{
  imports = [
    ./dconf
    ./extensions
  ];

  options.gnome = {
    enable = lib.mkEnableOption "GNOME desktop environment configuration";

    dconf.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.gnome.enable;
      description = "Enable GNOME dconf settings";
    };
  };

  config = lib.mkIf config.gnome.enable {
    # Create wallpapers directory in home
    home.file."Pictures/wallpapers/shaded_landscape.png".source = wallpaper;
  };
}
