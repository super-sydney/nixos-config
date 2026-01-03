{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./localisation.nix
    ./network.nix
    ./services.nix
    ./users.nix
  ];

  # Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Boot configuration
  boot = {
    # Bootloader
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        timeoutStyle = "hidden";
        theme = pkgs.catppuccin-grub;
      };
    };

    # Quiet boot
    consoleLogLevel = 3;
    initrd.verbose = false;
    plymouth = {
      enable = true;
      theme = "catppuccin-mocha";
      themePackages = [ (pkgs.catppuccin-plymouth.override { variant = "mocha"; }) ];
    };

    # Default kernel parameters (igpu mode)
    kernelParams = lib.mkDefault [
      # Quiet boot
      "quiet"
      "splash"
      "loglevel=3"
      "systemd.show_status=0"
      "rd.systemd.show_status=0"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "rd.loglevel=3"
      "rd.systemd.log_level=3"
      # Filesystem checks
      "fsck.mode=auto"
      "fsck.repair=no"
      # Power management
      "mem_sleep_default=deep"
      "pcie_aspm.policy=powersupersave"
      # Disable NVIDIA dGPU
      "module_blacklist=nouveau,nvidia,nvidia_drm,nvidia_modeset,nvidia_uvm"
    ];

    # Blacklist NVIDIA modules by default
    blacklistedKernelModules = lib.mkDefault [
      "nouveau"
      "nvidia"
      "nvidia_drm"
      "nvidia_modeset"
      "nvidia_uvm"
    ];
  };

  # Hardware configuration
  hardware = {

    # Graphics (default: igpu)
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # Default to AMD GPU driver
  services.xserver.videoDrivers = lib.mkDefault [ "amdgpu" ];

  # System modules (from /modules/nixos)
  hardware.keyboard.qmk.enable = true;
  fish.enable = true;
  nvtop.enable = true;
  steam.enable = true;
  virtualisation.enable = true;

  # GPU specialisations
  specialisation = {
    # Hybrid mode: igpu + dgpu on demand (nvidia-offload)
    hybrid.configuration = {
      services.xserver.videoDrivers = [ "nvidia" ];

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

      # Remove NVIDIA module blacklist
      boot.blacklistedKernelModules = lib.mkForce [];
      boot.kernelParams = lib.mkForce [
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

    # NVIDIA sync mode: Always use NVIDIA GPU
    nvidia.configuration = {
      services.xserver.videoDrivers = [ "nvidia" ];

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

      # Remove NVIDIA module blacklist
      boot.blacklistedKernelModules = lib.mkForce [];
      boot.kernelParams = lib.mkForce [
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
  };  system.stateVersion = "25.05";

}
