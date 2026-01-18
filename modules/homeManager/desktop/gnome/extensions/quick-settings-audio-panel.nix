{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gnome.extensions.quick-settings-audio-panel.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Quick Settings Audio Panel extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.quick-settings-audio-panel.enable {
    home.packages = [ pkgs.gnomeExtensions.quick-settings-audio-panel ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "quick-settings-audio-panel@rayzeq.github.io" ];
      };

      "org/gnome/shell/extensions/quick-settings-audio-panel" = {
        add-button-applications-output-reset-to-default = true;
        always-show-input-volume-slider = true;
        create-applications-volume-sliders = true;
        create-balance-slider = false;
        create-perdevice-volume-sliders = false;
        create-profile-switcher = false;
        group-applications-volume-sliders = true;
        ignore-css = true;
        master-volume-sliders-show-current-device = true;
        merged-panel-position = "top";
        mpris-controllers-are-moved = true;
        panel-type = "separate-indicator";
        perdevice-volume-sliders-change-button = true;
        perdevice-volume-sliders-change-menu = false;
        widgets-order = [
          "profile-switcher"
          "output-volume-slider"
          "perdevice-volume-sliders"
          "balance-slider"
          "input-volume-slider"
          "applications-volume-sliders"
          "mpris-controllers"
        ];
      };
    };
  };
}
