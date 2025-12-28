{ config, lib, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-format = "24h";
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      document-font-name = "FiraCode Nerd Font  11";
      enable-animations = true;
      font-antialiasing = "grayscale";
      font-hinting = "full";
      font-name = "Fira Sans 12";
      gtk-enable-primary-paste = false;
      monospace-font-name = "FiraMono Nerd Font 12";
      show_battery_percentage = true;
    };
  };
}
