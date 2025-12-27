{ config, pkgs, lib, ... }:

{
  options.gnome.extensions.user-themes.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable User Themes extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.user-themes.enable {
    home.packages = [ pkgs.gnomeExtensions.user-themes ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" ];
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "catppuccin-mocha-mauve-standard+default";
      };
    };
  };
}
