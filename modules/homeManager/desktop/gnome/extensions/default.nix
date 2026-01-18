{
  config,
  lib,
  ...
}:

{
  imports = [
    ./appindicator.nix
    ./arcmenu.nix
    ./battery-time.nix
    ./blur-my-shell.nix
    ./dash-to-dock.nix
    ./just-perfection.nix
    ./open-bar.nix
    ./pop-shell.nix
    ./quick-settings-audio-panel.nix
    ./quicksettings-audio-devices-renamer.nix
    ./rounded-window-corners-reborn.nix
    ./screen-rotate.nix
    ./user-themes.nix
    ./vitals.nix
  ];
}
