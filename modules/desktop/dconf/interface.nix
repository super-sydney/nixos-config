{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.ubuntu-sans
    fira-code
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-format = "24h";
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      document-font-name = "UbuntuSans Nerd Font 11";
      enable-animations = true;
      font-antialiasing = "grayscale";
      font-hinting = "full";
      font-name = "UbuntuSans Nerd Font 12";
      gtk-enable-primary-paste = false;
      monospace-font-name = "FiraCode Nerd Font Mono 11";
      show_battery_percentage = true;
    };
  };
}
