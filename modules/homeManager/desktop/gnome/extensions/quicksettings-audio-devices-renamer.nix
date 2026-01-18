{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gnome.extensions.quicksettings-audio-devices-renamer.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Quick Settings Audio Devices Renamer extension for GNOME Shell.";
  };

  config = lib.mkIf config.gnome.extensions.quicksettings-audio-devices-renamer.enable {
    home.packages = [ pkgs.gnomeExtensions.quick-settings-audio-devices-renamer ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [ "quicksettings-audio-devices-renamer@marcinjahn.com" ];
      };

      "org/gnome/shell/extensions/quicksettings-audio-devices-renamer" = {
        input-names-map = with lib.hm.gvariant; [
          (mkDictionaryEntry [
            "Internal Microphone – Family 17h/19h/1ah HD Audio Controller"
            "Laptop"
          ])
        ];
        output-names-map = with lib.hm.gvariant; [
          (mkDictionaryEntry [
            "HDMI / DisplayPort 2 – Renoir/Cezanne HDMI/DP Audio Controller"
            "Speakers"
          ])
          (mkDictionaryEntry [
            "Speakers – Family 17h/19h/1ah HD Audio Controller"
            "Laptop"
          ])
          (mkDictionaryEntry [
            "Headphones – Family 17h/19h/1ah HD Audio Controller"
            "IEMs"
          ])
        ];
      };
    };
  };
}
