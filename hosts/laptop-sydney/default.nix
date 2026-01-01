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
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 1;

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev"; # EFI mode
      timeoutStyle = "hidden"; # Skip menu unless pressing shift
      theme = pkgs.catppuccin-grub;
    };
  };

  # Quiet boot
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.plymouth = {
    enable = true;
    theme = "catppuccin-mocha";
    themePackages = [ (pkgs.catppuccin-plymouth.override { variant = "mocha"; }) ];
  };

  # Base graphics stack
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Default: iGPU-only for maximum battery life
  environment.etc."nixos-specialisation".text = "igpu\n";
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidia"
    "nvidia_drm"
    "nvidia_modeset"
    "nvidia_uvm"
  ];
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "systemd.show_status=0"
    "rd.systemd.show_status=0"
    "udev.log_level=3"
    "rd.udev.log_level=3"
    "rd.loglevel=3"
    "rd.systemd.log_level=3"
    "fsck.mode=auto"
    "fsck.repair=no"
    "mem_sleep_default=deep"
    "pcie_aspm.policy=powersupersave"
    # Disable NVIDIA dGPU completely
    "module_blacklist=nouveau,nvidia,nvidia_drm,nvidia_modeset,nvidia_uvm"
  ];

  # GPU specialisations
  specialisation = {
    # Hybrid: PRIME offload (render on NVIDIA, display via AMD)
    hybrid.configuration = {
      environment.etc."nixos-specialisation".text = "hybrid\n";
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.production;
        open = true; # GTX 1650 Max-Q (Turing) → use open kernel modules
        modesetting.enable = true;
        nvidiaSettings = true;
        forceFullCompositionPipeline = true;
        powerManagement.enable = true;
        powerManagement.finegrained = true;
        dynamicBoost.enable = true;
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
      # Override kernelParams to remove module_blacklist
      boot.kernelParams = [
        "quiet"
        "splash"
        "loglevel=3"
        "systemd.show_status=0"
        "rd.systemd.show_status=0"
        "udev.log_level=3"
        "rd.udev.log_level=3"
        "rd.loglevel=3"
        "rd.systemd.log_level=3"
        "fsck.mode=auto"
        "fsck.repair=no"
        "mem_sleep_default=deep"
        "pcie_aspm.policy=powersupersave"
      ];
    };

    # NVIDIA-only: make dGPU primary via PRIME sync
    nvidia.configuration = {
      environment.etc."nixos-specialisation".text = "nvidia\n";
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.production;
        open = true; # GTX 1650 Max-Q (Turing) → use open kernel modules
        modesetting.enable = true;
        nvidiaSettings = true;
        forceFullCompositionPipeline = true;
        powerManagement.enable = true;
        powerManagement.finegrained = true;
        dynamicBoost.enable = true;
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true; # provides nvidia-offload helper
          };
          amdgpuBusId = "PCI:8:0:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
      boot.blacklistedKernelModules = [ "nouveau" ];
      # Override kernelParams to remove module_blacklist
      boot.kernelParams = [
        "quiet"
        "splash"
        "loglevel=3"
        "systemd.show_status=0"
        "rd.systemd.show_status=0"
        "udev.log_level=3"
        "rd.udev.log_level=3"
        "rd.loglevel=3"
        "rd.systemd.log_level=3"
        "fsck.mode=auto"
        "fsck.repair=no"
        "mem_sleep_default=deep"
        "pcie_aspm.policy=powersupersave"
      ];
    };
  };

  # NixOS Modules
  fish.enable = true;
  nvtop.enable = true;
  steam.enable = true;
  virtualisation.enable = true;

  # Hardware
  hardware.keyboard.qmk.enable = true; # QMK for use with via

  system.stateVersion = "25.05";

}
