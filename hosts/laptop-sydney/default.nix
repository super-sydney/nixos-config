{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./localisation.nix
    ./network.nix
    ./services.nix
    ./users.nix
  ];

  # Enable flakes & nix command
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Optimise store contents and enable automatic GC
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly"; # run gc weekly
    options = "--delete-older-than 7d"; # keep last 7 days of generations
  };

  # Bootloader settings
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # Base graphics stack
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # GPU specialisations
  specialisation = {
    # Default: iGPU-only for maximum battery life
    igpu.configuration = {
      # Use AMD iGPU driver, block NVIDIA modules
      services.xserver.videoDrivers = [ "amdgpu" ];
      boot.blacklistedKernelModules = [
        "nouveau"
        "nvidia"
        "nvidia_drm"
        "nvidia_modeset"
        "nvidia_uvm"
      ];
    };

    # Hybrid: PRIME offload (render on NVIDIA, display via AMD)
    hybrid.configuration = {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.production;
        open = true; # GTX 1650 Max-Q (Turing) → use open kernel modules
        modesetting.enable = true;
        powerManagement.enable = true;
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true; # provides nvidia-offload helper
          };
          amdgpuBusId = "PCI:8:0:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
      # Prevent nouveau from loading when using NVIDIA proprietary driver
      boot.blacklistedKernelModules = [ "nouveau" ];
    };

    # NVIDIA-only: make dGPU primary via PRIME sync
    nvidia.configuration = {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.production;
        open = true; # Use open kernel modules on 560+ drivers
        modesetting.enable = true;
        powerManagement.enable = true;
        prime = {
          sync.enable = true;
          amdgpuBusId = "PCI:8:0:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
      boot.blacklistedKernelModules = [ "nouveau" ];
    };
  };

  # NixOS Modules
  fish.enable = true;
  steam.enable = true;
  virtualisation.enable = true;

  system.stateVersion = "25.05";

}
