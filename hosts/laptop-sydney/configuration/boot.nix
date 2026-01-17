{
  config,
  pkgs,
  lib,
  ...
}:

{
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
}
