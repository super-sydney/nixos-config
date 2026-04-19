{
  config,
  pkgs,
  lib,
  ...
}:

{
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

  # Power down dGPU on boot via systemd oneshot service
  systemd.services."system76-gpu-poweroff" = {
    description = "Power off dGPU on boot (System76)";
    wantedBy = [ "multi-user.target" ];
    after = [
      "systemd-modules-load.service"
      "dbus.service"
      "system76-power.service"
    ];
    requires = [ "system76-power.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecCondition = ''
        ${pkgs.bash}/bin/bash -c '
          for dev in /sys/bus/pci/devices/*; do
            vendor=$(cat "$dev/vendor" 2>/dev/null || echo "")

            # 0x10de is nvidia
            [ "$vendor" = "0x10de" ] || continue

            # If runtime_status exists
            if [ -f "$dev/power/runtime_status" ]; then
              state=$(cat "$dev/power/runtime_status")
              # exit 0 if not suspended, exit 1 if already suspended
              [ "$state" != "suspended" ] && exit 0
              exit 1
            fi

            # If runtime_status does not exist, assume it's on and exit 0
            exit 0
          done

          # No nvidia found
          exit 1
        '
      '';
      ExecStart = "${pkgs.system76-power}/bin/system76-power graphics power off";
      TimeoutStartSec = 10;
    };
  };

  # Power down dGPU after resume from suspend (only when in integrated mode)
  environment.etc."systemd/system-sleep/99-system76-gpu-poweroff" = {
    text = ''
      #! /bin/sh
      case "$1" in
        post)
          if [ "$( ${pkgs.system76-power}/bin/system76-power graphics )" = "integrated" ]; then
            ${pkgs.system76-power}/bin/system76-power graphics power off
          fi
          ;;
      esac
    '';
    mode = "0755";
  };

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
      boot.blacklistedKernelModules = lib.mkForce [ ];
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

      # Disable poweroff service and resume hook to keep dGPU powered
      systemd.services."system76-gpu-poweroff".enable = lib.mkForce false;
      environment.etc."systemd/system-sleep/99-system76-gpu-poweroff".enable = lib.mkForce false;

      # Override system76-power modprobe config to allow NVIDIA modules
      environment.etc."modprobe.d/system76-power.conf".text = lib.mkForce ''
        blacklist nouveau
        alias nouveau off
      '';
    };

    # NVIDIA sync only works on x11 (see https://wiki.nixos.org/wiki/NVIDIA)
  };
}
