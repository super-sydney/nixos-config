{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration
  ];

  # Nix settings
  nix = {
    optimise.automatic = true;

    settings = {
      auto-optimise-store = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
      persistent = true;
    };
  };

  # Allow root auto-upgrade to commit the lock file
  environment.etc."gitconfig".text = ''
    [safe]
      directory = /home/sydney/.config/nixos
    [user]
      name = Sydney
      email = sydneykho@proton.me
  '';

  # Automatic system updates
  system.autoUpgrade = {
    enable = true;
    operation = "boot"; # Don't switch to new config until next boot
    runGarbageCollection = true;
    flake = "/home/sydney/.config/nixos";
    flags = [
      "--print-build-logs"
      "--update-input"
      "nixpkgs"
      "--update-input"
      "home-manager"
      "--update-input"
      "zen-browser"
      "--update-input"
      "dw-proton"
      "--commit-lock-file"
    ];
    dates = "weekly";
    persistent = true;
    allowReboot = false;
  };

  # System modules (from /modules/nixos)
  hardware.keyboard.qmk.enable = true;
  nautilusOpenAnyTerminal.enable = true;
  nix-ld.enable = true;
  nvtop.enable = true;
  opentabletdriver.enable = true;
  steam.enable = true;
  syncthing.enable = true;
  virtualisation.enable = true;

  system.stateVersion = "25.05";

}
