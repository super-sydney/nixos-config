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

      "org/gnome/shell/extensions/blur-my-shell" = {
        settings-version = 2;
      };

      "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
        blur=true;
        brightness=0.6;
        sigma=30;
      };

      "org/gnome/shell/extensions/blur-my-shell/applications" = {
        blur=true;
        enable-all=false;
      };

      "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = {
        pipeline="pipeline_default";
      };

      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        blur=false;
        brightness=0.6;
        pipeline="pipeline_default";
        sigma=30;
        static-blur=true;
        style-dash-to-dock=0;
      };

      "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
        pipeline="pipeline_default";
      };

      "org/gnome/shell/extensions/blur-my-shell/overview" = {
        blur=true;
        pipeline="pipeline_default";
        style-components=0;
      };

      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur=true;
        brightness=0.6;
        pipeline="pipeline_default";
        sigma=30;
      };

      "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
        pipeline="pipeline_default";
      };

      "org/gnome/shell/extensions/blur-my-shell/window-list" = {
        brightness=0.6;
        sigma=30;
      };

      
    };
  };
}
