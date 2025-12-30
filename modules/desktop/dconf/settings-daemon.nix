{ config, lib, ... }:

{
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      control-center = [ "<Super>i" ];
      home = [ "<Super>f" ];
      play = [ "<Control>Delete" ];
      screensaver = [ "<Super>l" ];
      www = [ "<Super>b" ];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal" = {
      binding = "<Super>t";
      command = "kitty";
      name = "Open Kitty";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = true;
      sleep-inactive-ac-timeout = 1800;
      sleep-inactive-ac-type = "suspend";
      sleep-inactive-battery-timeout = 900;
      sleep-inactive-battery-type = "suspend";
    };
  };
}
