{ config, pkgs, lib, ... }:

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

  # NixOS Modules
  fish.enable = true;
  nvtop.enable = true;
  steam.enable = true;
  virtualisation.enable = true;

  # Hardware
  hardware.keyboard.qmk.enable = true; # QMK for use with via

  # Default specialisation (igpu)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = lib.mkDefault [ "amdgpu" ];
  boot.blacklistedKernelModules = lib.mkDefault [
    "nouveau"
    "nvidia"
    "nvidia_drm"
    "nvidia_modeset"
    "nvidia_uvm"
  ];

  boot.kernelParams = lib.mkDefault [
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

  specialisation = {
    hybrid.configuration = {
      hardware.graphics.enable = true;
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.amdgpu.initrd.enable = true;
      hardware.nvidia = {
        open = true;
        modesetting.enable = true;
        powerManagement.enable = true;
        prime = {
          offload.enable = true;
          offload.enableOffloadCmd = true;
          nvidiaBusId = "PCI:1:0:0";
          amdgpuBusId = "PCI:8:0:0";
        };
      };

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

    nvidia.configuration = {
      hardware.graphics.enable = true;
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.amdgpu.initrd.enable = true;
      hardware.nvidia = {
        open = true;
        modesetting.enable = true;
        powerManagement.enable = true;
        prime = {
          sync.enable = true;
          nvidiaBusId = "PCI:1:0:0";
          amdgpuBusId = "PCI:8:0:0";
        };
      };

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

  system.stateVersion = "25.05";

}
