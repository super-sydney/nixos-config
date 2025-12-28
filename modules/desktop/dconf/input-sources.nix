{ config, lib, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "caps:swapescape" ];
    };
  };
}
