{ config, lib, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/settings-daemon/peripherals/touchscreen" = {
      orientation-lock = false;
    };
  };
}
