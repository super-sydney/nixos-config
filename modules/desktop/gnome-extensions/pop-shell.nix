{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gnome.extensions.pop-shell.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable pop-shell extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.pop-shell.enable {
    home.packages = [ pkgs.gnomeExtensions.pop-shell ];
    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "pop-shell@system76.com" ];
      };
      # "org/gnome/shell/extensions/pop-shell" = {
      #   icon-brightness = 0.0;
      #   icon-contrast = 0.0;
      #   icon-opacity = 240;
      #   icon-saturation = 0.0;
      #   icon-size = 0;
      # };
    };
  };
}
