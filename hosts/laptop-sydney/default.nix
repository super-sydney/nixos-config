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
      dates = "weekly";
      options = "--delete-older-than 7d";
      persistent = true;
    };
  };

  # Automatic system updates
  system.autoUpgrade = {
    enable = true;
    operation = "boot"; # Don't switch to new config until next boot
    runGarbageCollection = true;
    flake = inputs.self.outPath;
    flags = [
      "--print-build-logs"
      "--update-input"
      "--commit-lock-file"
    ];
    dates = "daily";
    persistent = true;
    allowReboot = false;
  };

  # System modules (from /modules/nixos)
  hardware.keyboard.qmk.enable = true;
  nautilusOpenAnyTerminal.enable = true;
  nix-ld.enable = true;
  nvtop.enable = true;
  # opentabletdriver.enable = true;
  steam.enable = true;
  syncthing.enable = true;
  virtualisation.enable = true;

  system.stateVersion = "25.05";

}
