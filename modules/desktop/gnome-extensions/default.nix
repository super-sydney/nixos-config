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
    ./appindicator.nix
    ./arcmenu.nix
    ./blur-my-shell.nix
    ./dash-to-dock.nix
    ../dconf
    ./just-perfection.nix
    ./open-bar.nix
    ./pop-shell.nix
    ./screen-rotate.nix
    ./user-themes.nix
    ./vitals.nix
  ];

  options.gnome.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable GNOME shell configuration.";
  };

  config = lib.mkIf config.gnome.enable {
    # Create wallpapers directory in home
    home.file."Pictures/wallpapers/shaded_landscape.png".source = wallpaper;
  };
}
