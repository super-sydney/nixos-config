{ config, pkgs, lib, ... }:

{
  options.gnome.extensions.blur-my-shell.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Blur my Shell extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.blur-my-shell.enable {
    home.packages = [ pkgs.gnomeExtensions.blur-my-shell ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "blur-my-shell@aunetx" ];
      };

      # Extension-specific configuration
      # Uncomment and customize as needed:
      # "org/gnome/shell/extensions/blur-my-shell" = {
      #   sigma = 30;
      #   brightness = 0.6;
      # };
    };
  };
}
