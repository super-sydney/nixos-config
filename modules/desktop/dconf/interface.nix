{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    fira-code
    fira-sans
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      accent-color = "purple";
      clock-format = "24h";
      clock-show-seconds = true;
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      document-font-name = "Fira Sans 12";
      enable-animations = true;
      font-antialiasing = "grayscale";
      font-hinting = "full";
      font-name = "Fira Sans 12";
      gtk-enable-primary-paste = false;
      monospace-font-name = "FiraCode Nerd Font Mono 11";
      show_battery_percentage = true;
    };
  };
}
