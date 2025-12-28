{ config, lib, ... }:

{
  dconf.settings = {
    "org/gnome/system/location" = {
      enabled = false;
    };

    "org/gnome/desktop/privacy" = {
      remember-recent-files = false;
    };

    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 300;
    };
  };
}
